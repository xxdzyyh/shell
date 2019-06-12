require 'fileutils' 
 
files = ["20.png","29.png","40.png","58.png","60.png","76.png","80.png","87.png","120.png","152.png","167.png","180.png"];
 
size =[20,29,40,58,60,76,80,87,120,152,167,180]

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