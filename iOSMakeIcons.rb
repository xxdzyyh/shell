require 'fileutils' 
 
files = ["40.png","58.png","60.png","80.png","87.png","120.png",
        "180.png"];
 
size =[40,58,60,80,87,120,180]

if ARGV[1] then #输出目录 
    for i in 0..files.size-1 do
    FileUtils.cp ARGV[0],files[i]
    system( "sips -z "+size[i].to_s+" "+ size[i].to_s + " "+ files[i] + " --out " + " " + ARGV[1].to_s);
    end
else
    for i in 0..files.size-1 do
    FileUtils.cp ARGV[0],files[i]
    system( "sips -z "+size[i].to_s+" "+ size[i].to_s + " "+ files[i])
    end
end