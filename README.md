# CISC3140_lab1
lab_1 for CISC3140

Author : Yuzhuang Chen

Operating systems : MacOS

[Reflection is on this readme file](#reflection)
<br>
<hr>
<br>

## Project Dir Structure

```text
    .
    ├── DaysCalc.sh
    ├── README.md
    ├── awk_group_work
    │   ├── data_set
    │   │   └── cars.csv
    │   └── test.awk
    ├── build.sh
    ├── makefile
    ├── sample.sh
    ├── sampledates.txt
    ├── softwares_info.txt
    ├── src
    │   ├── Date.txt
    │   ├── DaysCalc.class
    │   └── DaysCalc.java
    ├── terminal_session_record
    │   ├── script-2022-09-21-Github_submission.log
    │   ├── script-2022-09-21-JAVA_TEST.log
    │   ├── script-2022-09-21.log
    │   ├── script-2022-10-25-ALL_BASHFIE_TEST_LAB2.log
    │   ├── script-2022-10-25-JAVA_TESE_LAB2.log
    │   └── script-2022-10-25-MAKFILE_TEST_LAB2.log
    └── test.sh
        
```
- ### Lab 1
    - all terminal session record files is in terminal_session_record folder
    - .java(source files) of java is in src folder
    - .class files is in out folder
    - softwares_info.txt file is for Task1

<br>

- ### Lab 2
    - Dir Structure chenge
        - remove out dir for need it for now
    - added all the test log files to terminal_session_record, includes:
        - script-2022-10-25-JAVA_TESE_LAB2.log
        - script-2022-10-25-ALL_BASHFIE_TEST_LAB2.log
        - script-2022-10-25-MAKFILE_TEST_LAB2.log


<br>
<hr>
<br>

## <text id='reflection'>Reflection on Lab 2</id>
- ### Bash vs JAVA
    ``` text
        The similarity between bash scripts and Java source code is that the logic used is similar, and the difference between the two is very big in the basic syntax, the way variables are called, "()" is replaced by "[]", with line breaks or ";" to separate statements, and etc. The difference is that java is an object-oriented language, and uses a lot of objects and object member methods in the runtime. However, bash scripting is more of a functional development, implemented by multiple complex/simple instructions, and does not exist in objects. bash scripting functions return status codes with values from 0 to 255, while java functions can return any data type.
    ```
- ### Bash vs Makefile
    ``` text
        The biggest difference between bash script and makefile is that 1) the syntax format is different in the way variables are called, assignment operators are different from bash's format, the way functions are called, and etc. The structure of the if else statement is roughly the same, but makefile's if else statement can't be used for 2) The structure of makefile has a target, which is similar to bash's function, and makes [target_name] when executing a target, which is very much like a function call, and makefile also allows the existence of functions. 3) The makefile is the same as bash The makefile can run the bash command with line breaks, indentation, ";" separating the statement and indicating which target the statement is written to. Personally, I think it is easier to use bash because it is more intuitive than makefile to process the input code
    ```

<br>
<hr>
<br>

## Helpful website for lab_1

### Search engine : Google

<hr>

1. Search Contents : script recording terminal mac

    - Link : 
        https://www.howtogeek.com/devops/how-to-record-linux-terminal-commands-with-script/

    - Note : The basic commands, operations, and parameters of script

<hr>

2. Search Contents : install nodejs mac brew
    
    - Link : https://treehouse.github.io/installation-guides/mac/node-mac.html

    - Note : Installing nodejs and npm using brew

<hr>

3. Search Contents : github ssh key

    - Link : https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

    - Note : Generate the ssh key and configure it to github (github official documentation)

<hr>

4. Search Contents : java api

    - Link : https://docs.oracle.com/en/java/javase/17/docs/api/
    
    - Note : java api site

<hr>