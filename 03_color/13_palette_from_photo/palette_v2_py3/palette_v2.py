########################################
# "Palette from Photo"                 #
# or k-means clustering                #
# Exercise on page 156 of CCM          #
# demo code by Lingdong Huang          #
########################################

import numpy as np
import cv2

n_clusters = 5 #desired number of clusters

# read image, truncate the border artifacts in the old test image
im = cv2.imread("data/airplane.png")[2:,2:]

# run kmeans
samples = np.reshape(im,(im.shape[0]*im.shape[1],im.shape[2])).astype(np.float32)/255.0
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 300, 1.0)
ret,label,center=cv2.kmeans(samples,n_clusters,None,criteria,10,cv2.KMEANS_RANDOM_CENTERS)

# make a picture for the palette
palette = cv2.resize((np.reshape(center,(n_clusters,1,3))*255).astype(np.uint8),(100,im.shape[1]),interpolation=cv2.INTER_NEAREST)

# generate the posterized image
poster = label.reshape((im.shape[0],im.shape[1])).astype(np.int16)
poster = -np.dstack((poster,poster,poster))-1
for i in range(n_clusters):
  poster = np.where(poster==[-i-1,-i-1,-i-1], (center[i]*255).astype(np.int16), poster)
poster = poster.astype(np.uint8)

# plot the image
cv2.imshow("",np.hstack((poster,palette)));cv2.waitKey(0)
