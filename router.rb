﻿#encoding 'utf-8'
#This file provide an common method to decide with route should be allocated to specified order
#In the end this should be done in database

def decide_route address
    return '[Z]' if address.include? '到店自提'
    return '[K]' if !address.include?('广州')
    return '[C]' if address.include? '白云'  
    return '[C]' if address.include? '萝岗' 
    return '[C]' if address.include? '增城'
    return '[C]' if address.include? '花都' 
    return '[C]' if address.include? '从化' 
    return '[C]' if address.include? '南沙' 
    return '[C]' if address.include? '黄埔'
    return '[Q]' if address.include? '欧泊'
    return '[Q]' if address.include? '雅居乐'
    return '[G]' if address.include? '新月明珠花园'
    return '[P]' if address.include? '番禺'
    return '[G]'
end
