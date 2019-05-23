# ENGN4528 project - Jigsaw Puzzle Solver

## TO START
Hi there!

This is the initial commit of the project. Let's use this ReadMe file as a notice board.

Project milestones and issues have been updated.
Feel free to explore and add anything you want.

### Some quick guide on Git
1. when you want to have a brand new copy from the server

    `git clone https://gitlab.cecs.anu.edu.au/u6227591/engn4528-project.git`

2. when you want to add a new file
    
    `git add <filename>` (e.g. `git add calibrate.m`)

3. when you have made some changes and want to keep a log at this point (assume the files are added to git)
 
    **commit** (locally) `git commit -am "some meaningful commit message to easily recognize later"`

    **push** the commit(s) `git push origin master` or `git push`

4. when your teammates say they pushed something

    `git pull origin master` or `git pull`
    
5. when a conflict is potentially to happen (that is, your teammates pushed something while you are editting)
    
    **commit** first whatsoever `git commit "I made some changes about..."`

    **pull** `git pull origin master` or `git pull`
    This pull command will pull the change from your teammates and push your new commit(s) as the same time. Hopefully (as long as you are editting different parts of the project), the 'conflict' will be solved automatically (two versions will be merged).

Some [recourses](https://cs.anu.edu.au/pages/courses/comp2100/lectures/campus_only/) on git (a lot, here is a link to a ANU course teaching Git) and a corresponding small [exercise](https://cs.anu.edu.au/pages/courses/comp2100/labs/campus_only/lab2/). (log in using your gitlab account)

## ALGORITHM BASED ON PAPER
[Robust Solvers for Square Jigsaw Puzzles]

1. combine MGC and SSD
2. construct the compatibility matrix
3. normalize compatibility matrix
4. treat normalized MGC scores as a complete bipartite graph, find optimal matching by [Hungarian algorithm](http://www.hungarianalgorithm.com/hungarianalgorithm.php)
5. for each pair, take either MGC or M+S score according to the rule
6. construct MST according to this [paper](https://ieeexplore.ieee.org/ielx5/6235193/6247647/06247699.pdf?tp=&arnumber=6247699&isnumber=6247647&ref=aHR0cHM6Ly9pZWVleHBsb3JlLmllZWUub3JnL2RvY3VtZW50LzYyNDc2OTk=) section 4.2

### formula
- **DDS**
<img src="bin/formula1.png" alt="drawing" width="400"/>

- **MGC**
<img src="bin/formula2.png" alt="drawing" width="400"/>
<img src="bin/formula3.png" alt="drawing" width="400"/>

- **M+S**
<img src="bin/formula4.png" alt="drawing" width="400"/>

- **wMGC**
<img src="bin/formula5.png" alt="drawing" width="400"/>

## BASIC SKELETON
Here are some meeting conclusions from 24/4 (Wed week 7).

- preparation: choose and print an image, crop by hand, take photos
<img src="bin/step1.png" alt="drawing" width="600"/>

- pre-processing: crop, resize, equalisation (if needed), corner detection (if needed)
<img src="bin/step2.png" alt="drawing" width="600"/>

- **matching: compute similarities, match them vertically, then horizontally**
<img src="bin/step3.1.png" alt="drawing" width="600"/>
<img src="bin/step3.2.png" alt="drawing" width="600"/>