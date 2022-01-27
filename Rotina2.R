#Apagando a memoria do R
remove(list=ls())

#Instalando o ExpImage
#install.packages("ExpImage")

#Ativando o ExpImage
library(ExpImage)

#Indicando a pasta de trabalho
setwd_script()

#Abrindo as paletas de cores
fundo=read_image("Fundo.jpg", plot=TRUE)
palma=read_image("palma.jpg", plot=TRUE)
mdf=read_image("FundoPreto.jpg", plot=TRUE)

#Carregando a imagem da palma
imagema=read_image("IMG_0105.JPG", plot=TRUE)

#Diminuindo a resolucao da imagem
imagem=resize(imagema,w = 600)

#Fazendo a segmentacao pelo metodo logit
seg=segmentation_logit(im =imagem,
                   foreground = list(mdf),
                   background = list(fundo,palma),
                   fillHull = TRUE,
                   plot=TRUE
                    )
#Carregando funcao para corte automatico da imagem
source("https://raw.githubusercontent.com/AlcineiAzevedo/ProdPalma/main/Funcoes.txt")

#Cortando a imagem
coord=coord_crop(seg = seg)
imagem2=crop_image(imagem,w = coord$x1:coord$x2,h = coord$y1:coord$y2)


#Fazendo a segmentação na imagem cortada
seg2=segmentation_logit(im =imagem2,
                           foreground = list(palma),
                           background = list(mdf),
                           fillHull = TRUE,
                           plot=TRUE
)


#Apresentando as imagens
par(mfrow = c(2, 2))
plot_image(imagem)
plot_image(seg)
plot_image(imagem2)
NumPixels=sum(seg2) #estimando o numero de pixels
NumPixels
imagem3=extract_pixels(im=imagem2,target = seg2,plot=F)
plot_meansures(img = imagem3,coordy = 150,coordx = 150,text =paste(NumPixels,"pixels"))

par(mfrow = c(1,1))


