
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
	set command "${command} ${args}"
	
	#Set Command
	set AlsoDisp "No"
	set EigenData "No"
	set ModeNumber 1
	ExportModel $FileName $AlsoDisp $EigenData $ModeNumber
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
	set command "${command} ${args}"
	
	#Set Command
	set AlsoDisp "Yes"
	set EigenData "No"
	set ModeNumber 1
	ExportModel $FileName $AlsoDisp $EigenData $ModeNumber
	exec cmd.exe /c $command &

}

proc PlotAnime {args} {

	set command "BraineryWiz.exe PlotAnime"
	
	
	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	set command "$command FileName {$FileName}"
	
	#Set Options
	set command "${command} ${args}"
	
	#Set Command
	set AlsoDisp "No"
	set EigenData "No"
	set ModeNumber 1
	ExportModel $FileName $AlsoDisp $EigenData $ModeNumber
	exec cmd.exe /c $command &

}

proc PlotModeShape {args} {

	set command "BraineryWiz.exe PlotModeShape"
	
	
	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	set command "$command FileName {$FileName}"
	
	#Set Options
	set command "${command} ${args}"
	
	#Set Command
	set AlsoDisp "No"
	set EigenData "Yes"
	set ModeNumber [lindex $args 0]
	ExportModel $FileName $AlsoDisp $EigenData $ModeNumber
	exec cmd.exe /c $command &

}


proc ExportModel {{FileName "Brainery.Wiz"} {AlsoDisp "No"} {EigenData "No"} {ModeNumber 1}} {
	
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

	if {[expr [string match "Yes" $EigenData ]==1]} {
		
		set a [eigen $ModeNumber]
		puts $outfile1 "%EigenValues% $ModeNumber: $a"
		
		foreach nd $nodes {
		
			set a [nodeEigenvector $nd $ModeNumber]
			puts $outfile1 "%NodeEigenVector% $nd: $a"	
			
			}	
	}
	
	# get Element tags and corresponding element nodes----------------------
	set elements [getEleTags]
	
	foreach ele $elements {

		set a [eleNodes $ele]
		puts $outfile1 "%EleNode% $ele: $a"
		
		}	

	# get Retained and constrained nodes ------------------------------------------------------
	set retained [getRetainedNodes]
	
	foreach retain $retained {

		set a [getConstrainedNodes $retain]
		puts $outfile1 "%RetConsNode% $retain: $a"
	
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
		
	# get Fixed nodes and DOFs-----------------------------------------------
	set FixedNodes [getFixedNodes]
	foreach nd $FixedNodes {
			set a [getFixedDOFs $nd]
			puts $outfile1 "%nodeFixedDOFs% $nd: $a"
		}
	
	# get fiberData2 for elements--------------------------------------------
	foreach ele $elements {

		set a [eleResponse $ele section fiberData2]
		if {$a!=""} {
			puts $outfile1 "%eleFiberData2% $ele: $a"
			}
		
		}	
	
	# get axis for elements--------------------------------------------
	foreach ele $elements {
		set a ""
		set b [eleResponse $ele xaxis]
		set a "$a $b"
		set b [eleResponse $ele yaxis]
		set a "$a, $b"
		set b [eleResponse $ele zaxis]
		set a "$a, $b"
		puts $outfile1 "%eleAxis% $ele: $a"
		
		}	
		
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
	
	set data [string trim $data ", "];  #To remove last comma
	
	# Open The File ---------------------------------------------------
	set outfile1 [open $FileName a]	
	# Write the file with -nonewline option 
	puts -nonewline $outfile1 "{${data}}%%"
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