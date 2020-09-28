# DVDRipToMKV
Batch-convert DVD-Rip to MKV using Windows PowerShell and MakeMKV

### Requirements
* Windows PowerShell. 
* MakeMKV (download from www.makemkv.com).
* A folder containing ripped DVDs in the following format: 

        ...\FolderConatiningRippedDVDs\DVDName\Video_TS\VIDEO_TS.IFO 

    Folder and file names can be anything you like. Each ` .mkv ` file will be named after the folder containing the associated ripped DVD - e.g., ` DVDName.mkv `.

## Instructions
1. Download and run the included PowerShell script ` DVDRipToMKV.ps1 `. When the script runs you should see a welcome screen and a menu.
2. Press `1` to change the source folder from the default ` D:\Movies ` to the folder containing your ripped DVDs. (This folder should contain a folder for each ripped DVD, and each of those folders should contain a folder with at least one ` .IFO ` file.) To change the default, simply type the full path of your chosen folder: e.g., ` C:\Users\YourName\Videos ` and press ` ENTER ` .
3. If you didn't install MakeMKV in the default directory you will also need to enter the location of your ` makemkvcon.exe ` file. You can find this in your MakeMKV install directory. Once you've found the path of your ` makemkvcon.exe ` file, press `2` and type in the full path: e.g., ` D:\MakeMKV\makemkvcon.exe ` and press ` ENTER `.
4. By default, **DVDRipToMKV** will save the `.mkv ` files it creates into the source folder. For example, if your source folder is 

        D:\FolderConatiningRippedDVDs\DVDName\Video_TS\VIDEO_TS.IFO 
        
    the new ` .mkv ` file will be saved into

        D:\FolderConatiningRippedDVDs\DVDName 

    by default. If you would like to save your ` .mkv ` files somewhere else, you can press `3` at the main menu and input a new save location. As an example, if you set the save location to ` D:\MyMKVFiles `, then, **DVDRipToMKV** will  save each ` .mkv ` file into a folder named after the parent directory of your source. For example, if your ` .IFO ` file is located at 

        D:\FolderConatiningRippedDVDs\DVDName\Video_TS 
        
    as in our previous example, the ` .mkv ` file created from it will be saved in 
    
        D:\MyMKVFiles\DVDName
        
5. Once you have set up **DVDRipToMKV** to your liking, press ` ENTER ` at the main menu to start the conversion process. Your source folder will be scanned for ` .IFO ` files, and each will be converted to ` .mkv ` at your chosen save location. The PowerShell window will display your progress as you go, and show any errors that occur.
