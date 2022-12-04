
# /* ****************************************************************** **
# **                    BraineryWiz TCL version                         **
# **              by Bijan Sayyafzadeh & Silvia Mazzoni                 **
# **                                                                    **
# **                                                                    **
# ** (C) Copyright 2022, Bijan Sayyafzadeh & Silvia Mazzoni             **
# **       SilviaBrainery.com                                           **
# ** All Rights Reserved.                                               **
# **                                                                    **
# ** Commercial use of this program without express permission of the   **
# ** https://www.silviasbrainery.com/ (BraineryWiz@Gmail.com), is       **
# ** strictly prohibited.  See file 'COPYRIGHT'  in main directory      **
# ** for information on usage and redistribution,  and for a            **
# ** DISCLAIMER OF ALL WARRANTIES.                                      **
# **                                                                    **
# ** Developed by:                                                      **
# **   Bijan SayyafZadeh (B.Sayyaf@yahoo.com)                           **
# **   SilviaMazzoni     (SilviaMazzoni@Yahoo.com)                      **
# **                                                                    **
# ** ****************************************************************** */


proc PlotModel {args} {

	set command "BraineryWiz.exe PlotModel"
	
	
	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	set command "$command FileName {$FileName}"
	
	#Set Options
	set command "${command}[SetOptions $args]"
	
	#Set Command
	set AlsoDisp "No"
	ExportModel $FileName $AlsoDisp
	exec cmd.exe /c $command &

}


proc PlotDefo {args} {

	set command "BraineryWiz.exe PlotDefo"
	
	
	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	set command "$command FileName {$FileName}"
	
	#Set Options
	set command "${command}[SetOptions $args]"
	
	#Set Command
	set AlsoDisp "Yes"
	ExportModel $FileName $AlsoDisp
	exec cmd.exe /c $command &

}



proc SetOptions {argsl} {
	
	#Function to plot the model with options:
	#Title (and the title should be enter after it)
	#DrawNodesOff: Not to show Nodes
	#ShowNodeTag: To show Nodes tag
	#ShowEleTag: To show Elements tag
	#OnHover: To show Data in Hover Format
	#Sample : PlotModel DrawNodesOff ShowEleTag OnHover
	
	set command ""
	#Set NotDrawWireShadow
	if {[lsearch $argsl NotDrawWireShadow]!=-1} {

		set command "$command NotDrawWireShadow"
		
	}	
	
	#Set ScaleFactor
	if {[lsearch $argsl ScaleFactor]!=-1} {
	
		set a [lsearch $argsl ScaleFactor]
		set ScaleFactor [lindex $argsl [expr $a+1]]
		set command "$command ScaleFactor $ScaleFactor"
		
	} 	

	
	#set the Title
	if {[lsearch $argsl Title]!=-1} {
	
		set a [lsearch $argsl Title]
		set Title [lindex $argsl [expr $a+1]]
		set command "$command Title $Title"
		
	} 
		
	
	#Set to Not Draw Nodes
	if {[lsearch $argsl DrawNodesOff]!=-1} {

		set command "$command DrawNodesOff"
		
	}
	
	#Set Show nodes Tag
	if {[lsearch $argsl ShowNodeTag]!=-1} {

		set command "$command ShowNodeTag"
		
	}

	#Set Show Constrained
	if {[lsearch $argsl ShowConstrained]!=-1} {

		set command "$command ShowConstrained"
		
	}
	
	#Set ConstrainedSize
	if {[lsearch $argsl ConstrainedSize]!=-1} {

		set a [lsearch $argsl ConstrainedSize]
		set SIZE [lindex $argsl [expr $a+1]]
		set command "$command ConstrainedSize $SIZE"
		
	}	
	
	#Set to Show Elements Tag
	if {[lsearch $argsl ShowEleTag]!=-1} {

		set command "$command ShowEleTag"
		
	}
	
	#Set to Add hovers
	if {[lsearch $argsl OnHover]!=-1} {

		set command "$command OnHover"
		
	}	
	
	#To plot Legends on the plot
	if {[lsearch $argsl PlotLegend]!=-1} {

		set command "$command PlotLegend"
		
	}

	
	#To set Vertical Axis on the plot
	if {[lsearch $argsl VerticalAxis_2]!=-1} {

		set command "$command VerticalAxis_2"
		
	}
	if {[lsearch $argsl VerticalAxis_1]!=-1} {

		set command "$command VerticalAxis_1"
		
	}

	
	
	return $command

}
proc ExportModel {{FileName "Brainery.Wiz"} {AlsoDisp "No"}} {
	
	# Function that Export Model Data
	
	# First Open The File ---------------------------------------------------
	set outfile1 [open $FileName w]
	
    # get Nodes tag and corresponding nodes coordinates and displacement if needed----------------------
	set nodes [getNodeTags]

	foreach nd $nodes {
	
			set a [nodeCoord $nd]
			puts $outfile1 "%NodeCoord% $nd: $a"
			
		}
		
	if {[expr [string match "Yes" $AlsoDisp ]==1]} {
	
		foreach nd $nodes {
		
			set a [nodeDisp $nd]
			puts $outfile1 "%NodeDisp% $nd: $a"	
			
			}	
	}
		
	# get Element tags and corresponding element nodes----------------------
	set elements [getEleTags]
	
	foreach ele $elements {

		set a [eleNodes $ele]
		puts $outfile1 "%EleNode% $ele: $a"
		
		}	

	# get Retained and constrained nodes ------------------------------------------------------
	# The following commands are not available in latest release of Opensees 3.2.2 so I comment it until next release
	# set retained [retainedNodes]
	
	# foreach retain $retained {

		# set a [constrainedNodes $retain]
		# puts $outfile1 "%RetConsNode% $retain: $a"
	
	# }	
	
	# get element type------------------------------------------------------
	# foreach ele $elements {

		# set a [eleType $ele]
		# puts $outfile1 "%eleType% $ele: $a"
		
		# }	
		
	# get IP locations-------------------------------------------------------
	# foreach ele $elements {

		# set a [sectionLocation $ele]
		# puts $outfile1 "%EleSeclocations% $ele: $a"
		
		# }		
		
	# get IP weights---------------------------------------------------------
	# foreach ele $elements {

		# set a [sectionWeight $ele]
		# puts $outfile1 "%sectionWeight% $ele: $a"
		
		# }					
		
    # get Nodal Masses ------------------------------------------------------
	# foreach nd $nodes {
			# set a [nodeMass $nd]
			# puts $outfile1 "%nodeMass% $nd: $a"
		# }
		
    # get Nodal DOFs---------------------------------------------------------
	# foreach nd $nodes {
			# set a [nodeDOFs $nd]
			# puts $outfile1 "%nodeDOFs% $nd: $a"
		# }
		
	# get Model info---------------------------------------------------------
	puts $outfile1 "%nodeBounds% [nodeBounds]"		
	
	#Finally close File------------------------------------------------------
	close $outfile1
	
	#Check File existance and return the file directory and path------------- 
	#Get Current Directory
	# set CurrentDir [pwd]
	# puts $CurrentDir

	#Set full path directory and file name
	# set FuleFilePath "[file join $CurrentDir $FileName] "
	# puts "FullPath=$FuleFilePath"

	#Check if the file is created
	set fexist [file exist $FileName]
	# puts $fexist
	
	#Final Message if file has been created and warning if file has not been created
	if {$fexist==1} {
		#puts "Data file has been created in below address: \n \n $FileName \n"
	} else {
		puts "Data file has not been created for some unknown reasons!!!"
	}	
	
}

proc Record {{FileName "BrainRecorder.txt"}} {
	#Function that records model displacement
	
    # get Nodes tag and corresponding nodes Displacement----------------------
	set nodes [getNodeTags]
	set data ""
	puts "****** START ******"
	foreach nd $nodes {
			set disp [nodeDisp $nd]
			
			set d ""
			foreach dis $disp {
				set d "${d}$dis, "
			}
			set d [string trim $d ", "];  #To remove last comma
			
			#Write into the format
			set data "${data}\"$nd\": \[$d\], "
			
			
	}
	# Open The File ---------------------------------------------------
	set outfile1 [open $FileName a]	
	# Write the file
	puts $outfile1 "{${data}}%%"
	# Close the opened file 
	close $outfile1
}
proc RecorderReset {{FileName "BrainRecorder.txt"}} {
	#Function that Clear the recorded file
	
	# Open The File ---------------------------------------------------
	set outfile1 [open $FileName w]
	
	# Close the opened file 
	close $outfile1
}