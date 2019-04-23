#encoding 'utf-8'
#This file provide an common method to decide with route should be allocated to specified order
#In the end this should be done in database

def decide_route address

    return '[Z]' if address.include? '到店自提'
    return '[Z]' if address.include? '汉溪村'

    return '[P]' if address.include? '祈福'
    return '[P]' if address.include? '金山谷'
    return '[P]' if address.include? '欧泊' 
    return '[P]' if address.include? '红郡'
    return '[P]' if address.include? '富豪山庄'
    return '[P]' if address.include?('雅居乐') && !address.include?('南城')
    return '[P]' if address.include? '清华坊'
    return '[P]' if address.include?('南奥') || address.include?('南国奥')
    return '[P]' if address.include? '锦绣香江'
    return '[P]' if address.include? '华南新城'
    return '[P]' if address.include? '雅居乐'
    return '[P]' if address.include? '华南碧桂园'
    return '[P]' if address.include?('星河湾') && !address.include?('半岛')

    if address.include? '广州'
      #Insert any exception here
      return '[G]' if address.include? '白云路'

      #normal area
      return '[G]' if address.include? '天河'
      return '[G]' if address.include? '海珠'
      return '[G]' if address.include? '越秀'
      return '[G]' if address.include? '荔湾'
    end

    return '[C]'
 
end
