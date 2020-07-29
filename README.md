# Docker Container for Training GPT-2

Only requirements are Nvidia docker 
### clone repo

`git clone https://github.com/Danny-Dasilva/gpt2.git`

### path into repo

`cd gpt2`
### build docker container
`sudo docker build ./ -t gpt2`

### export current directory
`GPT_DIR=$PWD`


### run container local files are mounted in the local folder
```
docker run --name create-text \
--rm -it --privileged -p 6006:6006 \
--mount type=bind,src=${GPT_DIR},dst=/home/gpt2/local \
--gpus all \
gpt2 
```

### second terminal is you need it

```
sudo docker exec -it create-text /bin/bash 
```

## Train and Deploy model

### Add your text file 
put your txt file in ${GPT_DIR} (the cloned repo)

the following examples will use the example file of `training.txt` 

if you want examples on how to format the txt file that info is provided below

### Encode to training.npz

in the docker container 

`python3 encode.py local/training.txt training.npz`

### Train Model
run name here is run1 this will be the same as the model name later

`python3 train.py --dataset training.npz --run_name run1`

the model will save automatically at 1000 steps but if you hit <kbd>Ctrl</kbd> + <kbd>C</kbd>  it will save the most recent step, sometimes if you train for too short you will get a `ValueError("Can't load save_path when it is None.")` I think it has something to do with the tokens not delimiting correcly because the model is not trained enough.


### Run model
below is for unconditional e.g. generated text

`python3 generate_unconditional_samples.py --top_k 40 --model_name run1`


### Interactive samples
these will ask for a model prompt

`python3 interactive_conditional_samples.py --top_k 40 --model_name run1 --length 25`


### model args explanations 


taken from https://medium.com/@ngwaifoong92/beginners-guide-to-retrain-gpt-2-117m-to-generate-custom-text-content-8bb5363d8b7f


* **top_k**: Integer value controlling diversity. 1 means only 1   word is considered for each step (token), resulting in deterministic completions, while 40 means 40 words are considered at each step. 0 (default) is a special setting meaning no restrictions. 40 generally is a good value.
    
* **temperature**: Float value controlling randomness in boltzmann distribution. Lower temperature results in less random completions. As the temperature approaches zero, the model will become deterministic and repetitive. Higher temperature results in more random completions. Default value is 1.
* **length**: number of characters included in each sample before a new sample is generated

## How do you format txt files?

the example said to delimit with `<|endoftext|>` but you can use whatever

files should  look like below

```
Example sentence or paragraph of text
<|endoftext|>
Another text thing
<|endoftext|>
```
