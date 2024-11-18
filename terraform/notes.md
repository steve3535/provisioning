* esx datastore gen replaces - with _ leading to datastore not found 
* apparently exceptions going silent on tf_generator when calling from app.py, and thus, does not produce the vm tf file
  * e.g. I was using this in the block for dmz vm  *guest_id  = "{var.vsphere_guest_os}"*   
    because of var not known in the python script (its a tf keyword), it was failing  
    easiest solution was to just put it in a try .. except block   
* There might be a use case to pick the OS from an additional field, so that we have the user inputs its prefrred OS -- log an issue  
* nut-dmz-07 - 08 retirés car ils sont plus op - donc retirés de app.py et main.tf   
* !! be careful not having duplicate images in any of the PC -- !!
