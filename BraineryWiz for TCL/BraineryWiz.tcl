
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

	set command "BraineryWiz.exe PlotModel"
	
	
	# Set the file name
	set FileName [info script]
	# set FileName [file tail $pathdir]
	set length [string length $FileName]
	set FileName [string range $FileName 0 [expr $length-5]]
	set FileName "$FileName.wiz"
	set command "$command FileName {$FileName}"
	
	#set the Title
	if {[lsearch $args Title]!=-1} {
	
		set a [lsearch $args Title]
		set Title [lindex $args [$a+1]]
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
	

	
	ExportModel $FileName
	exec cmd.exe /c $command &
	# exec cmd.exe /c "BraineryWiz.exe FileName $FileName" &
}


proc ExportModel {{FileName "Brainery.Wiz"}} {
	
	# Function that Export Model Data
	
	# First Open The File ---------------------------------------------------
	set outfile1 [open $FileName w]
	
    # get Nodes tag and corresponding nodes coordinates----------------------
	set nodes [getNodeTags]

	foreach nd $nodes {
			set a [nodeCoord $nd]
			puts $outfile1 "%NodeCoord% $nd: $a"
		}
		
	# get Element tags and corresponding element nodes----------------------
	set elements [getEleTags]
	
	foreach ele $elements {

		set a [eleNodes $ele]
		puts $outfile1 "%EleNode% $ele: $a"
		
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
	
}
