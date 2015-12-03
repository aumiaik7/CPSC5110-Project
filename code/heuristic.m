function x = heuristic()

fileID = fopen('input.txt');
_subjects = textscan(fileID,'%s',1,'Delimiter',' ');
_times = textscan(fileID,'%s',1,'Delimiter','#');
sizeA = [8 Inf];
M = fscanf(fileID,'%f %f %f %f %f %f %f %f %f %f %f',sizeA);
M=M';
fclose(fileID);
[m,n] = size(M);
maxVals = [];
five = [7 10];
seven = [5];
ten = [5];
for col=1:n
  [val,maxIndex] =  max(M(:,col));
  maxVals = [maxVals;maxIndex val];
  for j=2:n
    M(maxIndex,j) = 0;
  end
  if maxIndex == 5
    for k=1:length(five)
      for l=1:n
        M(five(1,k),l) = 0;
      end
    end
  
  elseif maxIndex == 7
    for k=1:length(seven)
      for l=1:n
        M(seven(1,k),l) = 0;
      end
    end
  
  elseif maxIndex == 10
    for k=1:length(ten)
      for l=1:n
        M(ten(1,k),l) = 0;
      end
    end
  end
  end
  
  for i=5:8
    for j=5:7
      if maxVals(j,2) < maxVals(j+1,2)
        temp1 = maxVals(j,1);
        temp2 = maxVals(j,2);
        tempSub = _subjects{1}{j};
        maxVals(j,1) = maxVals(j+1,1);
        maxVals(j,2) = maxVals(j+1,2);
        maxVals(j+1,1) = temp1;
        maxVals(j+1,2) = temp2;
        _subjects{1}{j} = _subjects{1}{j+1};
        _subjects{1}{j+1} = tempSub;
     
        
      end 
    end
  end
  
  
  totalRating = maxVals(1,2)+maxVals(2,2)+max(maxVals(3,2),maxVals(4,2))+maxVals(5,2)+maxVals(6,2);
  fprintf('The taken subjects with corresponding meeting times and ratings are as follows:\n');
  fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{1},_times{1}{maxVals(1,1)},maxVals(1,2));
  fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{2},_times{1}{maxVals(2,1)},maxVals(2,2));
  if maxVals(3,2) > maxVals(4,2)
    fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{3},_times{1}{maxVals(3,1)},maxVals(3,2));
  else
    fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{4},_times{1}{maxVals(4,1)},maxVals(4,2));
  end
  fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{5},_times{1}{maxVals(5,1)},maxVals(5,2));
  fprintf('%s ,Time: %s ,Rating: %1.1f\n',_subjects{1}{6},_times{1}{maxVals(6,1)},maxVals(6,2));
  
  fprintf('Total Rating:%1.1f\n',totalRating);
 end

