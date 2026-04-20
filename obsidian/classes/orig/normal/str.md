# items
## props
### static
- \_self
- \_iter\_lt
- [ ] 
### dynamic
- [ ] 
### settings
- [ ] RegEx: там где аргумент стора она воспринимается как регулярка
	- [ ] в поиске просто не экранируется от gsub
	- [ ] а в сплите конвертируется в регулярку
### \_cache
- [ ] 
## methods
- [ ] `byte` ориг но арги переделаны на питон систему
### custom meta
- [ ] \_\_tonumber: 
- [ ] \_\_totable: .iter_lt
- [ ] \_\_tofunction: 
- [ ] \_\_toinstance: 
- [ ] \_\_tovector2: 
- [ ] \_\_tovector3: 
- [ ] \_\_tocframe: 
# meta
- [ ] \_\_index `x.y` 
- [ ] \_\_newindex: `x.y:str! = z:str!` замена всех подстрок `y` на `z` 
- [ ] \_\_call: `x(y:str!|int,z:str!|int) -> str` как в питоне
	- [ ] при `y,z:str` split
	- [ ] при `y,z:int` питоновский sub
- \_\_len: `#x`
- [ ] \_\_unm: `-x` reverse
- [ ] \_\_add: `x+y`
- [ ] \_\_sub: `x-y:str!|lts` удаление подстрок
- [ ] \_\_mul: `x*y` умножение 
- [ ] \_\_pow: `x^y` степень
- [ ] \_\_div: `x/y:str!` число|nil от gsub
- [ ] \_\_idiv: `x//y`
- [ ] \_\_mod: `x%y`
- \_\_eq: `x==y`
- [ ] \_\_lt: `x<y` количество букв
- [ ] \_\_le: `x<=y` количество букв
- \_\_concat: `x..y`
- [ ] \_\_iter: `in x` по буквам
- \_\_tostring: 
