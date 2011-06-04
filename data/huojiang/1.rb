# -*- encoding : utf-8 -*-
      require 'spreadsheet'
      worksheets = Spreadsheet.open('./2010单项奖学金.xls').worksheets
      raise RuntimeError,'请保证xls文件只含一个工作表' if worksheets.count != 1
      worksheet = worksheets.first
      firstrow = worksheet.row(0)
	    p firstrow
	    
	    p huojiangdengji_first = firstrow.index('获奖等级')
      p huojiangdengji_first ||= firstrow.index('奖项')
      p jin_e_first = firstrow.index('金额')
      p number_first = firstrow.index('学号')
      p name_first = firstrow.index('姓名')
      
      if !huojiangdengji_first or !number_first or !jin_e_first
        p firstrow = worksheet.row(1)
        p huojiangdengji_first = firstrow.index('获奖等级')
        p huojiangdengji_first ||= firstrow.index('奖项')
        p jin_e_first = firstrow.index('金额')
        p number_first = firstrow.index('学号')
        p name_first = firstrow.index('姓名')
      end
      raise RuntimeError,'不能没有获奖等级或金额列或学号列' if !huojiangdengji_first or !number_first or !jin_e_first

