function x = heuristic()
%Read data from file
fileID = fopen('input.txt');
_subjects = textscan(fileID,'%s',1,'Delimiter','#');
_times = textscan(fileID,'%s',1,'Delimiter','#');
sizeA = [8 Inf];
M = fscanf(fileID,'%f %f %f %f %f %f %f %f %f %f %f',sizeA);
M = M'; %Matrix for ratings
fclose(fileID);
[m,n] = size(M);
maxVals = [];
sameTime = [5 7 10;7 5 0;10 5 0]; %Conflicting meeting times

for col=1:n
  [val,maxIndex] =  max(M(:,col));% Find maximum rating from each column 
  maxVals = [maxVals;maxIndex val];
  
  %Deal with conflicticg meeting times   
   if maxIndex == sameTime(1,1)
      for k=1:3
        for l=1:n
          M(sameTime(1,k),l) = 0;
        end
      end
   elseif maxIndex == sameTime(2,1)
      for k=1:3
        for l=1:n
          M(sameTime(2,k),l) = 0;
        end
    end
  
   elseif maxIndex == sameTime(3,1)
      for k=1:3
        for l=1:n
          M(sameTime(3,k),l) = 0;
        end
      end
   else
      %Make the row of max rating zero
      for j=2:n
        M(maxIndex,j) = 0;
      end
  end
  end
  %sorting done for finding 2 FIN selective courses with maximum rating
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
  
  %Output
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

