# BOUN-Pars

BOUN-Pars is a deep learning-based dependency parser developed for Turkish. It is based on [Stanford's graph-based neural dependency parser](https://github.com/tdozat/Parser-v2) and uses linguistically oriented rules and benefits from morphological information of words.

BOUN-Pars creates dependency parse trees of Turkish sentences in CoNLL-U format.

The pre-processing steps of parsing from raw text: the segmentation, morphological tagging, and lemmatization tasks are performed by a pre-trained model by [TurkuNLP pipeline](https://turkunlp.org/Turku-neural-parser-pipeline/).

## How to run using Docker
1. Clone the repo
```bash
git clone https://github.com/BOUN-TABILab-TULAP/Boun-Parser.git
```
2. Launch a terminal in the root directory of the repo and build the Docker image where
- `-t` is the tag for the Docker image. You can provide any name you want
- `.` is the relative path to the Dockerfile 
```bash
docker build -t boun-parser .
```
3. Run the Docker image where
- `-d` indicates "detach", let the container run in the background
- `-p 5000:5000` indicates mapping port 5000 of the container to the port 5000 of the host.
```bash
docker run -d -p 5000:5000 boun-parser
```
4. Send a POST request
- via curl
    ```bash
    curl -X POST http://localhost:5000/evaluate 
   -H 'Content-Type: application/json' 
   -d '{"textarea":"Her istediğini yerine getiriyordum."}'

   > {"brat_conll": "# newdoc\n# newpar\n# sent_id = 1\n# text = Her istedi\u011fini yerine getiriyordum.\n1\tHer\ther\tDET\tDet\t_\t2\tdet\t_\t_\n2\tistedi\u011fini\tiste\tVERB\tVerb\tAspect=Perf|Case=Acc|Mood=Ind|Number[psor]=Sing|Person[psor]=3|Polarity=Pos|Tense=Past|VerbForm=Part\t3\tobj\t_\t_\n3\tyerine\tyer\tNOUN\tNoun\tCase=Dat|Number=Sing|Number[psor]=Sing|Person=3|Person[psor]=3\t0\troot\t_\t_\n4\tgetiriyordum\tgetir\tVERB\tVerb\tAspect=Prog|Mood=Ind|Number=Sing|Person=1|Polarity=Pos|Polite=Infm|Tense=Past\t3\tcompound\t_\tSpaceAfter=No\n5\t.\t.\tPUNCT\tPunc\t_\t3\tpunct\t_\tSpacesAfter=\\n\n\n\n\n"}
    ```
- via Python's requests library
    ```python
    import requests
    res = requests.post('http://localhost:5000/evaluate', json={'textarea':'Her istediğini yerine getiriyordum.'})
    print(res.json())

    > {"brat_conll": "# newdoc\n# newpar\n# sent_id = 1\n# text = Her istedi\u011fini yerine getiriyordum.\n1\tHer\ther\tDET\tDet\t_\t2\tdet\t_\t_\n2\tistedi\u011fini\tiste\tVERB\tVerb\tAspect=Perf|Case=Acc|Mood=Ind|Number[psor]=Sing|Person[psor]=3|Polarity=Pos|Tense=Past|VerbForm=Part\t3\tobj\t_\t_\n3\tyerine\tyer\tNOUN\tNoun\tCase=Dat|Number=Sing|Number[psor]=Sing|Person=3|Person[psor]=3\t0\troot\t_\t_\n4\tgetiriyordum\tgetir\tVERB\tVerb\tAspect=Prog|Mood=Ind|Number=Sing|Person=1|Polarity=Pos|Polite=Infm|Tense=Past\t3\tcompound\t_\tSpaceAfter=No\n5\t.\t.\tPUNCT\tPunc\t_\t3\tpunct\t_\tSpacesAfter=\\n\n\n\n\n"}
    ```

BOUN-Pars is developed by Şaziye Betül Özateş, Arzucan Özgür, Tunga Güngör from the Department of Computer Engineering, and Balkız Öztürk from the Department of Linguistics, at Bogazici University. 

Please cite the following papers if you make use of this tool:

```
@article{ozates2020hybrid,
         author ={Şaziye Betül Özateş,  Arzucan Özgür, Tunga Güngör, Balkız Öztürk},
         title ={A Hybrid Approach to Dependency Parsing: Combining Rules and Morphology with Deep Learning},
         journal ={Under Review}}
```
