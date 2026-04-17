# items
## props
### static
- \_self
- \_iter\_lt
- [ ] 
### dynamic
- [ ] 
### settings
- [ ] 
### \_cache
- [ ] 
## methods
- [ ] 
### custom meta
- [ ] \_\_tonumber: 
- [ ] \_\_totable: 
- [ ] \_\_tofunction: 
- [ ] \_\_toinstance: 
- [ ] \_\_tovector2: 
- [ ] \_\_tovector3: 
- [ ] \_\_tocframe: 
# meta
- \_\_index
- [ ] \_\_newindex: `x.y = z`
- [x] \_\_call: `x(y:int?)` получение потомков 
    -1 потомки  
    0 self
    1 дети
    2+ дети детей
    всё это gins
        функциональная группа ins 
        она должна дублировать поведение на всех ins в её списке
        () выход в lts
        если без аргов + self == gins то тогда это выход
- [ ] \_\_len: `#x`
- [x] \_\_unm: `-x` разгрупировывает `x` перемещяя его потомков в `x.parent` и сносит `x` через `:Destroy()`
- [x] \_\_add: `x+y:ins!` `y.parent = x`
- [x] \_\_sub: `x-y:ua!` удаляет детей по [[УА]]
- [x] \_\_mul: `x*y:ua!` копирует по [[УА]] через `:Clone()`
- [x] \_\_pow: `x^y:ua!` копирует по [[УА]] через `Instance.fromExisting(z)`
- [x] \_\_div: `x/y:ua!` вырезает по [[УА]] через `z.Parent = nil`
- [x] \_\_idiv: `x//y:ua!` разгрупировывает + вырезает по [[УА]] 
- [x] \_\_mod: `x%y:ua!` ищет по [[УА]]
- [x] \_\_eq: `x==y`
- [x] \_\_lt: `x<y`
- [x] \_\_le: `x<=y`
- [ ] \_\_concat: `x..y`
- [x] \_\_iter: `in x`
- [ ] \_\_tostring: 
