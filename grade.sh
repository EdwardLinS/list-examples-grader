CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
cd student-submission
echo 'Finished cloning'

if [[ -f ListExamples.java ]]
then
    echo "ListExamples found"
else
    echo "need file ListExamples.java"
    exit 1
fi

cp ../TestListExamples.java .
cp -r ../lib .
javac -cp $CPATH *.java

echo "Finished compiling"

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

if [[ `grep -h "OK" output.txt` != "" ]] 
then
    echo "All tests passed"
    echo `grep -h "test" output.txt`
else
    echo `grep -h "Tests run" output.txt`
    echo "testMergeRightEnd failed"
fi