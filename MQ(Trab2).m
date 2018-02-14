clear all
clc
% carrega arquivo de dados
data = importdata('parkson.mat');
y=data(:,1);
classMax=max(y);
classMin=(min(y));
[m,n] = size(data);
z=zeros(classMax,m);
for i=1:m, 
   z(round(y(i)),i)=1;
end

n=round(length(data(:,1))/8);
acertos=zeros(100,m,classMax);
baseCorreta=zeros(100,m,classMax);

for i=1:100, 
    [m,n] = size(data);
    data=data(randperm(m),:);
    k=round((8*m)/10);
    
    treino=data(1:k,:);
    teste=data(k+1:end,:);
    
    y=treino(:,1); 
    X=treino(:,2:end)';
    
    classMax=max(y);
    classMin=(min(y));
    Y=zeros(classMax,k);
    
    for i2=1:k, 
       Y(round(y(i2)),i2)=1;
    end
    
    A = Y/X;
    
    yteste=teste(:,1); 
    Yteste=zeros(classMax,m-k);
    Xteste=teste(:,2:end)';
    
    for i2=1:m-k, 
       Yteste(round(yteste(i2)),i2)=1;
    end
    
    Yh=A*Xteste;
    
    for j=1:m-k,
        [Mh,Ih] = max(Yh(:,j)); 
        [M,I] = max(Yteste(:,j)); 
        if I==Ih
            acertos(i,j,I)=acertos(i,j,I)+1;
        end    
        baseCorreta(i,j,I)=baseCorreta(i,j,I)+1;
    end
end



TaxAcertoC=zeros(1,100);
TaxMedClassC=zeros(100,classMax);
for i=1:100,
    for j=1:m,
        for k=1:classMax,
            TaxAcertoC(i)=TaxAcertoC(i)+baseCorreta(i,j,k);
            TaxMedClassC(i,k)=TaxMedClassC(i,k)+baseCorreta(i,j,k);
        end
    end
end





TaxAcerto=zeros(1,100);
TaxMedClass=zeros(100,classMax);
for i=1:100,
    for j=1:m,
        for k=1:classMax,
            TaxAcerto(i)=TaxAcerto(i)+acertos(i,j,k);
            TaxMedClass(i,k)=TaxMedClass(i,k)+acertos(i,j,k);
        end
    end
end

taxMin=min(TaxAcerto./TaxAcertoC)
taxMax=max(TaxAcerto./TaxAcertoC)
taxMed=mean(TaxAcerto./TaxAcertoC)
desvioP=std(TaxAcerto./TaxAcertoC)
TaxMedClass=mean(TaxMedClass./TaxMedClassC)

