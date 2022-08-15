../prepare-image.sh step1.png "470,502 820,600"
../prepare-image.sh step2.png "355,890 700,1030"
../prepare-image.sh step3.png "440,1740 2100,2095"
../prepare-image.sh step4.png "1300,900 1700,1000"
../prepare-image.sh step5.png
../prepare-image.sh test-case-results.png "440,1740 2100,1835" "440,1910 2100,2005"
../prepare-image.sh manual-comment.png
../prepare-image.sh manual-comment-overview.png
mogrify -format jpg meme.png
