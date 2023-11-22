def is_greater(lst1, lst2) -> bool:
  for i,j in zip(lst1[1:],lst2[1:]):
    if int(i)<int(j):
      return False
  return True

def is_lesser(lst1,lst2) -> bool:
  for i,j in zip(lst1[1:],lst2[1:]):
    if int(i)>int(j):
      return False
  return True

def relation(filename: str) -> str:
    students = []
    marks_lst = []
    filename_lst = filename.split(' ')
    
    for i in filename_lst:
      if i.isalpha():
        students.append(marks_lst)
        marks_lst = []
        marks_lst.append(i)
      elif i.isdigit():
        marks_lst.append(int(i))
    students.append(marks_lst)
    students = students[1:]
    stud_dict ={}
    for  i in students:
      sum=0
      for j in range(1,len(i)):
        sum+=i[j]
      stud_dict[i[0]] =sum
    answers = []
    ans_dict={}
    for i in students:
      answers=[i[0]]
      for j in students:
        if is_greater(i,j) and i!=j:
          answers.append(j[0])
        elif is_lesser(i,j) and i!=j:
          answers.append(j[0])
      ans_dict[i[0]]=answers
    letters=[]
    
    for i in range(len(students)):
      temp_lst = []
      for j in students:
        if len(ans_dict[j[0]]) == i:
          temp_lst.append(j[0])
      letters.append(temp_lst)
    temp = []
    for  i in letters:
      if i!=[]:
        temp.append(i)
    for i in temp:
      i.sort(key=lambda x: stud_dict[x], reverse = True)
    ans_str = ''
    for i in temp:
      for j,k in zip(i,range(len(i))):
        if k!=(len(i)-1):
          ans_str+=j
          ans_str+='>'
        else:
          ans_str+=j
      ans_str+='\n'
    return ans_str
print(relation('A 12 14 16 B 5 6 7 C 17 20 23 D 2 40 12 E 3 41 13 F 7 8 9 G 4 5 6'))

def isGreater(lst1, lst2) -> bool:
  for i in range(0,len(lst1)):
    if lst1[i]<lst2[i]:
      return False
  return True 

def isLesser(lst1,lst2) -> bool:
  for i in range(0,len(lst1)):
    if lst1[i]>lst2[i]:
      return False
  return True 