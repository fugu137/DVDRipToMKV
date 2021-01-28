# DVDRipToMKV
#### Batch-convert DVD-Rips to MKV using Windows PowerShell and MakeMKV

MakeMKV is a great program for ripping and converting DVDs to ` .mkv ` files, or for converting already ripped DVDs to ` .mkv `. The latter process is, however, limited in that users have to convert ripped DVDs one by one. This can be a very time-consuming process for users who have a large number of ripped DVDs. Enter **DVDRipToMKV**. **DVDRipToMKV** is a PowerShell script which allows users to choose a folder to scan for any ripped DVDs contained inside. The script then converts each ripped DVD to an ` .mkv ` file using MakeMKV, making the whole process much quicker and easier.

Feel free to use this to convert your own ripped DVDs to MKV! Instructions below.

![Image](DVDRipToMKV (2).png)

### Requirements
* Windows PowerShell. 
* MakeMKV (download the free beta version from www.makemkv.com).
* A folder containing ripped DVDs in the following format: 

        ...\FolderConatiningRippedDVDs\DVDName\Video_TS\VIDEO_TS.IFO 

    Folder and file names can be anything you like. Each ` .mkv ` file will be named after the folder containing the associated ripped DVD - e.g., ` DVDName.mkv `.

## Instructions
1. Download and run the included PowerShell script ` DVDRipToMKV.ps1 `. If you have Windows 7 or later, then you already have PowerShell installed. See https://www.howto-outlook.com/howto/powershell-scripts-faq-tips-and-tricks.htm for instructions for running a PowerShell script in Windows. When the script runs you should see a welcome screen and a menu.
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
