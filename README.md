# Docker Container for Training GPT-2

### clone repo

`git clone https://github.com/Danny-Dasilva/gpt2.git`

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
run name here is run1 
`python3 train.py --dataset training.npz --run_name run1`

the model will save automatically at 1000 steps but if you hit <kbd>Ctrl</kbd> + <kbd>C</kbd>  itl save the most recent step


### Run model
below is for unconditional e.g. generated text

`python3 generate_unconditional_samples.py --top_k 40 --model_name run1 `


### Interactive samples
these will ask for a model prompt
`python3 interactive_conditional_samples.py --top_k 40 --model_name run1 --length 25`


## How do you format txt files?

the example said to delimit with `<|endoftext|>` but you can use whatever

files should  look like below

```
Example sentence or paragraph of text
<|endoftext|>
Another text thing
<|endoftext|>
```
