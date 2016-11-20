function [assigns,centroids,clusterval]=googkmeans(data, initWeights, num)
    %randomly pick num centroids
    M=size(data,2);
    cids=randperm(M);
    cids=cids(1:num);
    centroids=data(cids);
    %repeat until no change
    flag=1;
    oldassigns=ones(1,M).*(num+1);
    while flag==1
        %assign points to centroids based on dtw
        for i=1:M
            d_mat=distfun(data(i), centroids, initWeights, num, size(initWeights,2));
            [~,assigns(i)]=min(d_mat);
        end
        if(min(assigns==oldassigns)==0)%change happened
            oldassigns=assigns;
        else
            flag=0;
        end
        %update centroids
        for i=1:num
            temp=data(assigns==i);
            [centroids{i},nullcentroid,meanvar(i)]=getclosestpoint(temp,...
                initWeights, size(initWeights,2));
            if(nullcentroid==1)
                breakhere=1;
            end
        end

        %  removing null centroids if any.
        j = 1;
        for i=1:num
            if(isempty(centroids{i}) == 0)
                updated_centroids{j} = centroids{i};
                j=j+1;
            end    
        end
        centroids = updated_centroids;
        num = size(centroids,2);
    end
    %inter cluster distance
    interdist=[];

    for i=1:num
        interdist=[interdist;distfun(centroids(i), centroids, initWeights, ...
            num, size(initWeights,2))];
    end
    clusterval=(min(interdist(interdist(:)~=0))*mean(meanvar(:)));
end

function distmat=distfun(point, C, initWeights, num, wsize)
    for i=1:num
    %     distmat(i)=dtw(point{1}',C{i}',5);
        distmat(i)=customizeddistfun(point{1}', C{i}', initWeights);
    end
end

function [centroid,flag,meanvar]=getclosestpoint(points, initWeights, wsize)
    nump=size(points,2);
    if(nump==0)
        centroid=[];
        flag=1;
        meanvar=-1;
        return
    end
    for i=1:nump
        for j=1:nump
    %         dista(i,j)=dtw(points{i}',points{j}',5);
              dista(i,j)=customizeddistfun(points{i}', points{j}', initWeights);
        end
    end

    [~,id]=min(mean(dista,2));
    centroid=points{id};
    flag=0;
    meanvar=mean(dista(:));
end