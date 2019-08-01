# -*- coding: UTF-8 -*-
import re
from enum import Enum

# 词法分析是词素到词法单元的过程
class TokenType(Enum):
	Init = 0
	Operator = 1
	Number = 2
	Keyword = 3
	String = 4
	Separator = 5
	Identify = 6

# 词法单元
class Token(object):
	def __init__(this):
		# 行号
		this.line = 0
		# 类型
		this.type = TokenType.Init
		this.value = 0

	def __str__(this):
		return "line:" + str(this.line) + ", type:" + str(this.type) + ", value:" + str(this.value)

# 词法分析器
class Lexer(object):

	def __init__(this):
		# 设置语言关键字
		this.keywords = ['b','c','f','i','lbc','lbw','lc','p','t','tc']
		# 设置分隔符
		this.separator = [',','(',')']
		# 设置操作符
		this.operator = [':'，'+']
		this.tokenObjects = []
		this.line_num = 0

	def read_file(this,filename):
		with open(filename,"r") as f_input:
			return [line.strip() for line in f_input]

	def run(this,line):
		this.line_num = this.line_num + 1
		# 去掉空白行
		if len(line) < 1:
			return
		else:
			# 去掉注释
			if line.startswith('//'):
				return


		each = []
		for letter in line:
			each.append(letter)

		#
		op_first = ''
		word = ''
		# 判断单个字符不能确定是什么，需要进一步判断
		# 0 是初始值
		# 1 是操作符
		# 2 是常数NUM
		# 3 是关键字或变量名
		# 4 是字符串 STRING
		oflag = 0
		

		for e in each:
			if oflag == 1:
				# 这个位置处理操作符是多个字符的情况
				if e in this.separator:
					this.addToken(TokenType.Separator,word)
				elif re.match(r'[a-zA-Z\_]',e):
					word = word + e
				oflag = 0
				

				continue
			elif oflag == 2:
				if e == '':
					this.addToken(TokenType.Number,word)
					word = ''
					oflag = 0
					
				elif e in this.separator:
					this.addToken(TokenType.Number,word)
					word = ''
					oflag = 0
					
			elif oflag == 3: # 是关键字或变量名
				if e == '':
					if word in this.keywords:
						this.addToken(TokenType.Keyword,word)	
					else:
						this.addToken(TokenType.Identify,word)
					word = ''
					oflag = 0
					
				elif e in this.separator:
					if word in this.keywords:
						this.addToken(TokenType.Keyword,word)	
					else:
						this.addToken(TokenType.Identify,word)
					word = ''
					oflag = 0
					
				elif e in this.operator:
					if word in this.keywords:
						this.addToken(TokenType.Keyword,word)	
					else:
						this.addToken(TokenType.Identify,word)	
					word = ''
					oflag = 0
					
				else:
					word = word + e
				continue
			elif oflag == 4:
				if e != '"':
					word = word + e
				elif e == '"':
					word = word + e
					this.addToken(TokenType.String,word)
					word = ''
					oflag = 0

				continue

			# 判断是否是操作符
			if e in this.operator:
				oflag = 1
				op_first = e
				continue

			# 判断是否是分隔符
			if e in this.separator:
				this.addToken(TokenType.Separator,e)
				continue

			# 判断是否是常数
			if re.match(r'[0-9\.]',e): 
				oflag = 2
				word = word + e
				continue

			#判断是否是关键字或者变量名
			if re.match(r'[a-zA-Z\_]',e):
				oflag = 3
				word = word + e
				continue

			#判断是否是字符串
			if e == '"':
				oflag = 4
				word = word + e
				continue

	def addToken(this,type,value):
		tokenObject = Token()
		tokenObject.type = type
		tokenObject.value = value
		tokenObject.line = this.line_num
		this.tokenObjects.append(tokenObject)




# 语法分析器
class Parser(object)
	

if __name__ == '__main__':
	lexer = Lexer()
	filepath = "/Users/xiaoniu/Workspace/shell/11.txt"
	lines = lexer.read_file(filepath)



	for line in lines:
		lexer.run(line)

	for obj in token.tokenObjects:
		print(obj)

