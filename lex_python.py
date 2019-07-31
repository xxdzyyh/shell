# -*- coding: UTF-8 -*-

import re

class Token(object):

	def __init__(this):
		# 设置语言关键字
		this.keywords = ['b','c','f','i','lbc','lbw','lc','p','t','tc']
		# 设置分隔符
		this.separator = [',','(',')']
		# 设置操作符
		this.operator = [':']

	def read_file(this,filename):
		with open(filename,"r") as f_input:
			return [line.strip() for line in f_input]

	def run(this,line):
		# # 去掉空白行
		# if len(i) < 1:
		# 	continue
		# else:
		# 	# 去掉注释
		# 	if line.startswith('//'):
		# 		continue

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
					print('operator-' + word + e)
				elif re.match(r'[a-zA-Z\_]',e):


					word = word + e
				oflag = 0
				continue
			elif oflag == 2:

				if e == '':
					print('number-' + word)
					word = ''
					oflag = 0
				elif e in this.separator:
					print('number-' + word)
					word = ''
					oflag = 0
			elif oflag == 3: # 是关键字或变量名
				if e == '':
					if word in this.keywords:
						print('keywords-' + word)
					else:
						print('identify-' + word)
					word = ''
					oflag = 0
				elif e in this.separator:
					if word in this.keywords:
						print('keywords-' + word)
					else: 
						print('identify-' + word)
					word = ''
					oflag = 0
				elif e in this.operator:
					if word in this.keywords:
						print('keywords-' + word)
					else: 
						print('identify-' + word)
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
					print('string' + word)
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
				print('separator-' + e)
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


if __name__ == '__main__':
	token = Token()
	filepath = "/Users/xiaoniu/Workspace/shell/11.txt"
	lines = token.read_file(filepath)

	for line in lines:
		token.run(line)

