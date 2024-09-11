# An Extremely Basic Protocol For Github

**Note:** This is an extremely basic protocol assuming you have already used `git clone`.

## How To Push To Github (Basic)

1) Figure out the file you want to push. For example if I want to push `Reference.txt` I will do the following

```bash
git add Reference.txt
```

If you want to add all the files use the following

```bash
git add -A
```

2) Then you need to `commit` the changes:

```bash
git commit -m "Description Of Your Choice"
```

3) Then `push`:

```bash
git push
```

4) If it says there are changes on the Github that you do not have locally use:

```bash

git pull

```

## Note(s):

* Work on the files you want on Github in the git cloned directory.
* Some files may not render properly if they are uploaded and not pushed.
