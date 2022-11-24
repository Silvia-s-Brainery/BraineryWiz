
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
	#Function to plot the model with options:
	#Title (and the title should be enter after it)
	#DrawNodesOff: Not to show Nodes
	#ShowNodeTag: To show Nodes tag
	#ShowEleTag: To show Elements tag
	#OnHover: To show Data in Hover Format
	#Sample : PlotModel DrawNodesOff ShowEleTag OnHover

	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	
	# Export Data 
	set command "BraineryWiz.exe"  
	set a [ExportModel $FileName]
	set command "$command $a"
	set command "$command PlotModel"
	

	set command "$command FileName {$FileName}"
	
	#set the Title
	if {[lsearch $args Title]!=-1} {
	
		set a [lsearch $args Title]
		set Title [lindex $args [expr $a+1]]
		set command "$command Title $Title"
		
	} 
		
	
	#Set to Not Draw Nodes
	if {[lsearch $args DrawNodesOff]!=-1} {

		set command "$command DrawNodesOff"
		
	}
	
	#Set Show nodes Tag
	if {[lsearch $args ShowNodeTag]!=-1} {

		set command "$command ShowNodeTag"
		
	}
	
	#Set to Show Elements Tag
	if {[lsearch $args ShowEleTag]!=-1} {

		set command "$command ShowEleTag"
		
	}
	
	#Set to Add hovers
	if {[lsearch $args OnHover]!=-1} {

		set command "$command OnHover"
		
	}	
	
	#To plot Legends on the plot
	if {[lsearch $args PlotLegend]!=-1} {

		set command "$command PlotLegend"
		
	}

	
	#To set Vertical Axis on the plot
	if {[lsearch $args VerticalAxis_2]!=-1} {

		set command "$command VerticalAxis_2"
		
	}
	if {[lsearch $args VerticalAxis_1]!=-1} {

		set command "$command VerticalAxis_1"
		
	}
	
	
	exec cmd.exe /c $command &
	# exec cmd.exe /c "BraineryWiz.exe FileName $FileName" &
}


proc ExportModel {{FileName "Brainery.Wiz"}} {
	
	# Function that Export Model Data
	set NodesTag ""
	set NodesCoord ""
	set ElesTag ""
	set ElesNodes ""
	
	# First Open The File ---------------------------------------------------
	set outfile1 [open $FileName w]
	
    # get Nodes tag and corresponding nodes coordinates----------------------
	set nodes [getNodeTags]

	foreach nd $nodes {
			set a [nodeCoord $nd]
			set NodesTag "${NodesTag},$nd"
			puts $outfile1 "%NodeCoord% $nd: $a"
			
			set ea "";#To remove spaces
			foreach m $a {
				set ea "${ea}${m},"
			}
			set NodesCoord "${NodesCoord},\[${ea}\]"
		}
		
	# get Element tags and corresponding element nodes----------------------
	set elements [getEleTags]
	
	foreach ele $elements {
	
		set a [eleNodes $ele]
		set ElesTag "${ElesTag},$ele"
					
		puts $outfile1 "%EleNode% $ele: $a"
		
		set ea ""; #To remove spaces
		foreach m $a {
			set ea "${ea}${m},"
		}
		set ElesNodes "${ElesNodes},\[${ea}\]"
		}	
		
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
	set results "$NodesTag $NodesCoord $ElesTag $ElesNodes"
	return $results
	
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