# Select at least two programs then create an exe to run all of them at once.

# Message box .NET class
Add-Type -AssemblyName PresentationCore,PresentationFramework

## Open file dialog box

# load the System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# File select function
function Select-File {
    param([string]$Directory = $PWD)
  
    $dialog = [System.Windows.Forms.OpenFileDialog]::new()
  
    $dialog.InitialDirectory = (Resolve-Path $Directory).Path
    $dialog.RestoreDirectory = $true
  
    $result = $dialog.ShowDialog()
  
    if($result -eq [System.Windows.Forms.DialogResult]::OK){
      return $dialog.FileName
    }
  }

# Main
$Ans = "Y"
While($Ans -eq "Y")
{
  # Display dialog box and add path to file 
  $path = Select-File
  # Write-Output $path

  # Create and initialize array   
  $AppList += ,"$path"

  # Print list of select apps
  Write-Host "Your currently selected files: "
  Write-Output $AppList

  # Prompt user if they want to continue 
  $Ans = Read-Host -Prompt "Do you want to select another file? (Y/N)"
  if($Ans -eq "Y") {
    Write-Host "Continuing"
    continue
  }
  elseif ($Ans -eq "N") {
    Write-Host "Opening selected files"
  }
  else {throw}
}

# Loop array and execute apps
for ($i=0; $i -lt $AppList.Length; $i++){
  Start-Process -FilePath $AppList[$i]
}

# TODO
# Write output and code into separate script file
# Turn script into a .exe with PS2EXE Module