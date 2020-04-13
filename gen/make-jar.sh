
jar cvf react-java1.jar -C jni . \

jar cvf react-java2.jar -C ../bin/react/java/src . \

mkdir tempjar && cd tempjar \

jar -xf ../react-java1.jar \

jar -xf ../react-java2.jar \

jar -cf ../react-module-lib.jar . \

cd .. && rm -rf tempjar \

sleep 5
rm react-java1.jar \

rm react-java2.jar \

		