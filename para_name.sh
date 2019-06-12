
#!/bin/bash

# sh para_name.sh -b b_value -c c_value
# this is -b the arg is ! b_value
# this is -c the arg is !
 
# sh para_name.sh   -b b_value -c c_value -a a_value
# this is -b the arg is ! b_value
# this is -c the arg is ! 

# sh para_name.sh   -b b_value  -a a_value -c value
# this is -b the arg is ! b_value
# this is -a the arg is ! a_value
# this is -c the arg is ! 

# 注意:

while getopts "a:b:c" opt; do
  case $opt in
    a)
      echo "this is -a the arg is ! $OPTARG" 
      ;;
    b)
      echo "this is -b the arg is ! $OPTARG" 
      ;;
    c)
      echo "this is -c the arg is ! $OPTARG" 
      ;;
    \?)
      echo "Invalid option: -$OPTARG" 
      ;;
  esac
done

# 获取最后一个参数
echo "${@: -1}"

