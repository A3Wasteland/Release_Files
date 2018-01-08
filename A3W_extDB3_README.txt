A3W extDB3 MySQL instructions

 1. Extract everything from A3W_extDB3_pack.zip to your Arma 3 root directory, where arma3server is normally located
 2. Run the a3wasteland_db SQL script on your MySQL server
 3. Open @extDB3\extdb3-conf.ini and put your MySQL infos in the [A3W] section
 4. Add -filePatching -serverMod=@extDB3 to your arma3server command line, and allowedFilePatching = 1; to your server.cfg
 5. If you have a headless client, add -filePatching -mod=@extDB3 to your arma3server headless command line
 6. Check the Windows/Linux prerequisites below
 7. Try to start your server, and hope it doesn't blow in your face

Fow Windows, you need to install Visual C++ Redistributable Packages for Visual Studio 2015:
 https://download.microsoft.com/download/6/D/F/6DF3FF94-F7F9-4F0B-838C-A328D1A7D0EE/vc_redist.x64.exe
 https://download.microsoft.com/download/6/D/F/6DF3FF94-F7F9-4F0B-838C-A328D1A7D0EE/vc_redist.x86.exe

For Linux, you need to install libtbb2:
 apt-get install libtbb2:i386
 yum install tbb.i686

That should do it!

If you want to create a MySQL user with restricted access just for extDB, the privileges needed are: SELECT, INSERT, UPDATE, DELETE

A3Wasteland is currently compatible with extDB3 v1025 and up.

https://github.com/A3Wasteland/ArmA3_Wasteland.Altis
https://github.com/A3Wasteland/ArmA3_Wasteland.Stratis
https://github.com/A3Wasteland/ArmA3_Wasteland.Tanoa
https://github.com/A3Wasteland/ArmA3_Wasteland.Malden
