import htmlmin
from bs4 import BeautifulSoup
# with open("/Users/Shared/Unity/MathWorkingRule/Assets/Data/Question_Data.html", 'r+') as f:
# with open("../../unity_projects/new/UnityMathWorkingRules/Assets/Data/Question_Data.html", 'r+') as f:
#     text = f.read()
#     minified = htmlmin.minify(text.decode("utf-8"), remove_empty_space=True)
#     f.seek(0)
#     f.write(minified)
#     f.truncate()
"<body code='working-rule-for-check-if-a-math-statement-is-an-equation-or-not(=-sign)'></body>"
with open("/Users/shaunakdas2020/Documents/workspace/web_ui_math/working_rule_design/QuestionData.html", 'r+') as f:
    soup = BeautifulSoup(f.read(),"html.parser")
    for t in soup.find_all('body'):
		# print(unicode(t))
		html=unicode(t)
		minified = htmlmin.minify(html.decode("utf-8"), remove_empty_space=True)
		print(minified)