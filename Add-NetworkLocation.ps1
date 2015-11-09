function Add-NetworkLocation
{
    param(
        [string]$name,
        [string]$targetPath
    )
    
    # Get the basepath for network locations
    $shellApplication = New-Object -ComObject Shell.Application
    $nethoodPath = $shellApplication.Namespace(0x13).Self.Path

    # Only create if the local path doesn't already exist & remote path exists
    if ((Test-Path $nethoodPath) -and !(Test-Path "$nethoodPath\$name") -and (Test-Path $targetPath))
    {
        # Create the folder
        $newLinkFolder = New-Item -Name $name -Path $nethoodPath -type directory

        # Create the ini file
        $desktopIniContent = @"
[.ShellClassInfo]
CLSID2={0AFACED1-E828-11D1-9187-B532F1E9575D}
Flags=2
ConfirmFileOp=1
"@
        $desktopIniContent | Out-File -FilePath "$nethoodPath\$name\Desktop.ini"

        # Create the shortcut file
        $shortcut = (New-Object -ComObject WScript.Shell).Createshortcut("$nethoodPath\$name\target.lnk")
        $shortcut.TargetPath = $targetPath
        $shortcut.IconLocation = "%SystemRoot%\system32\SHELL32.DLL, 4"
        $shortcut.Description = $targetPath
        $shortcut.WorkingDirectory = $targetPath
        $shortcut.Save()
        
        # Set attributes on the files & folders
        Set-ItemProperty "$nethoodPath\$name\Desktop.ini" -Name Attributes -Value ([IO.FileAttributes]::System -bxor [IO.FileAttributes]::Hidden)
        Set-ItemProperty "$nethoodPath\$name" -Name Attributes -Value ([IO.FileAttributes]::ReadOnly)
    }
}
 
