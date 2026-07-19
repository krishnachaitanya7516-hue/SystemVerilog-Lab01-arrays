`timescale 1ns / 1ps



module test_array();

        // Declare a dynamic array data_da of int data type
           int data_da[];

        // Declare queues data_q & addr_q of int data type
           int data_q[$] , addr_q[$], value[$];

        // Declare associative array data_mem of int data type and indexed with bit[7:0]
             int data_mem[int] ; bit[7:0] indx=1;

        // Declare int variable result,and and an 8 bit variable idx
              int result; bit[0:7]idx;
        int addr; int first_idx , last_idx;

        initial
                begin

                        // Allocate 10 memory locations for dynamic array & initialize
                        // all the locations with some random values less than 20 & display the array
                        data_da=new[10];
                        foreach(data_da[j])
                                data_da[j]=$urandom_range(19,0);
                         foreach(data_da[j])
                                $display("data_da[%0d]=%0p",j,data_da[j]);

                #100;

                        // Call the array reduction method sum which returns the sum
                        // of all elements of array and collect the return value to the variable result
                        data_da=new[5];
                        data_da={1,3,4,5,6};
                       $display("new dynamic array=%0p",data_da);
                        result= data_da.sum();
                        $display("sum of all elements=%0d",result);
                #100;

                       


                        // Call the array reduction method sum with "with" clause which returns
                        // total number of elements satisfying the condition within the "with" clause
                        data_da=new[4];
                        data_da={2,3,4,8,9,10};
                        result = data_da.sum() with (int'(item>7));
                        $display("count of elments that are greater than 7=%0b",result);
                #100;
                        // Similarly explore other array reduction methods with "with"clause
                        result = data_da.sum() with(item<8);
                        $display("count of elments that are less than 8=%0b",result);
                #100;

                        



                        // Call Array locator methods like min, max, unique,find_* with,
                        // find_*_index with using dynamic array & display
                        // the contents of data_q after execution of each method to
                        // understand the behaviour of the array methods

                        value=data_da.max;
                        $display("maximum value of datat_da=%0p",value); #50;
                        value=data_da.min; #50;
                        $display("min value of data_da=%0p",value);
                        value=data_da.find_first with(item>5);$display("first element of data_da that is less than 5=%0p",value);  #50;
                        value=data_da.find_last with(item==9);$display("last element of data_da that is 9=%0p",value);  #50;
                        value=data_da.find_first_index with(item==4);$display("first index of data_da with element 4=%0p",value);  #50;
                        value=data_da.find_last_index with(item>8);$display("last index of data_da with element less than 8=%0p",value);   #50;
                        //Generate some 10 random address less than 100 within a repeat loop
                        //push the address in to the addr_q
                        repeat(10)
                        begin
                       addr=$urandom_range(0,99);
                        addr_q.push_front(addr);
                        end
                        //Display the addr_q
                foreach(addr_q[i])
                        $display("addr_q[%0b] = %0p",i,addr_q[i]);


                #100;
                        // With in for loop update the associate array with random data less than 200
                        // based on the address stored in addr_q
                        // Hint: To get the address use pop method
                        repeat(addr_q.size())
                        begin
                            addr=addr_q.pop_front();
                            data_mem[addr]=$urandom_range(199,0);
                        end

                        // Display the contents of associate array using foreach loop
                           foreach(data_mem[j])
                                $display("data_mem[%0b]=%0p",j,data_mem[j]);
                #100;

                        // Display the first index of the array by using associative array method first
                  if(data_mem.first(first_idx))
                     $display("first index = %0b",first_idx);
                #100

                        // Display the first element of the array
                 if(data_mem.first(first_idx))
                     $display("first index = %0d",data_mem[first_idx]);

                #100;
                        // Display the last index of the array by using associative array method last
                         if(data_mem.last(last_idx))
                     $display("first index = %0d",last_idx);
               #100;


                        // Display the last element of the array
                                if(data_mem.last(last_idx))
                     $display("first index = %0d",data_mem[last_idx]);

         #100
     $finish;

   end
