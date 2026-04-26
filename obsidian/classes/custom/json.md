# items
## props
### static
- \_self
- \_iter\_lt
- [ ] 
### dynamic
- [ ] 
### settings
- [ ] `Beautifier=bool`: форматирует строчку по красоте
- [ ] `sorting=bool`: сортирует элементы
### \_cache
- [ ] 
## methods
- [ ] [[lts#methods]]
### custom meta
- [ ] \_\_tonumber: вес данных
- [ ] \_\_totable: [[суперпозиция]]
- [ ] \_\_tofunction: [[суперпозиция]]
- [ ] \_\_toinstance: создание [[ins]] как из [[lts]]
- [ ] \_\_tovector2: [[суперпозиция]]
- [ ] \_\_tovector3: [[суперпозиция]]
- [ ] \_\_tocframe: [[суперпозиция]]
# meta
- [ ] \_\_index: `x.y:str!` индексация **json** **y** из **x**
- [ ] \_\_newindex: `x.y:str! = z:any` добавление **z** как **y** в **x**
- [ ] \_\_call: `x()`
- [ ] \_\_len: `#x` вес всего **x** 
- [ ] \_\_unm: `-x` переворот порядка элементов
- [ ] \_\_add: `x+y:any` добовление элемента как в [[array]]
- [ ] \_\_sub: `x-y:str!` удаление поля 
- [ ] \_\_mul: `x*y:int!` [[lts]]
- [ ] \_\_pow: `x^y` [[lts]]
- [ ] \_\_div: `x/y`
- [ ] \_\_idiv: `x//y`
- [ ] \_\_mod: `x%y`
- [ ] \_\_eq: `x==y` [[сравнение одинаковости]]
- [ ] \_\_lt: `x<y` сравнение веса
- [ ] \_\_le: `x<=y` вес + одинаковость
- [ ] \_\_concat: `x..y` объеденение 2 **json**
- [ ] \_\_iter: `in x` [[lts]]
- [ ] \_\_tostring: [[суперпозиция]]