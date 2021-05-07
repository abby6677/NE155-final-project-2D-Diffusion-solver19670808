function proceed=input_test(D,S,C,e,d)
    %Goal: chech if the input variables are reasonable
    
    %The size of the diffusion matrix D, the source matrix S, 
    %and the cross section matrix C, should be equal
    D_size=size(D);
    S_size=size(S);
    C_size=size(C);
    compare_DS=isequal(D_size,S_size);
    compare_DC=isequal(D_size,C_size);
    if compare_DS==true && compare_DC==true
        proceed='yes';
    else 
        proceed='no';
    end
    
    %The mesh spacings cannot be zero 
    if e>0 && d>0
        proceed='yes';
    else 
        proceed='no';    
    end
    
    %Print the outcome of the test
    display=['Can the DE solver proceed with proper inputs? :', proceed];
    disp(display)
    
   