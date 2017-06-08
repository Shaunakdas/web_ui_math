import htmlmin
with open("/Users/Shared/Unity/MathWorkingRule/Assets/Data/Question_Data.html", 'r+') as f:
    text = f.read()
    minified = htmlmin.minify(text.decode("utf-8"), remove_empty_space=True)
    f.seek(0)
    f.write(minified)
    f.truncate()