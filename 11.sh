#!/bin/bash

#for x in ${pub_subnet_a_id} ;do echo $x ;done


#array(${pub_subnet_c_id} ${pri_subnet_a_id})
array=(${pub_subnet_c_id} ${pri_subnet_a_id})
echo ${array[0]}
echo ${array[1]}

#array=('a' 'b')
#echo ${array[1]}
#${pri_subnet_c_id}

#ARRAY=("1" "2")
#ARRAY=("1" "2")