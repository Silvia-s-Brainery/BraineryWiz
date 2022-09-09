source BraineryWiz.tcl

wipe
model basic -ndm 2 -ndf 3

node 1 0. 0.
node 2 3. 0.
node 3 0. 3.
node 4 3. 3.

fix 1 1 1 1
fix 2 1 1 1

set A 1.0
set E 2.0e11
set Iz 10.0
set transfTag 1

geomTransf Linear $transfTag

element elasticBeamColumn 1 1 3 $A $E $Iz $transfTag
element elasticBeamColumn 2 2 4 $A $E $Iz $transfTag
element elasticBeamColumn 3 3 4 $A $E $Iz $transfTag

PlotModel ShowNodeTag OnHover ShowEleTag 

