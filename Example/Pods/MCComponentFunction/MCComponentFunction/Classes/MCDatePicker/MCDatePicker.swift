//
//  MCDatePicker.swift
//  MCAPI
//
//  Created by MC on 2018/8/13.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public typealias MCDatePickerClosure = (String) -> Void

public enum MCDateMode {
    case year
    case year_month
    case year_month_day
    
}

public class MCDatePicker: UIView {

    
    public var defaultDate     : Date  = Date.init()
    public var minimumDate     : Date  = MCDateManager_getDateFromString("1970-01-01")
    public var maximumDate     : Date  = MCDateManager_getDateFromString("2050-12-31")
    public var titleFont    : CGFloat = 14
    public var titleColor   : UIColor = UIColor.black
    
    public var datePickerClosure : MCDatePickerClosure?

    public func settingPickerView(mode:MCDateMode) {
        
        
        // 对三个时间（min，max，default）进行跳转
        judgeMin_max_defaultDateIsReasonableTime()
        
        
        dateMode = mode
        
        
        // 获取到默认，最大和最小的年
        let defaultYearStr = MCDateManager_getTimeStrFromDate(defaultDate, dateFormat: "yyyy")
        let maxYearStr = MCDateManager_getTimeStrFromDate(maximumDate, dateFormat: "yyyy")
        let minYearStr = MCDateManager_getTimeStrFromDate(minimumDate, dateFormat: "yyyy")
        defaultYear = Int(defaultYearStr) ?? 0
        maxYear = Int(maxYearStr) ?? 0
        minYear = Int(minYearStr) ?? 0
        

        
        // 获取到默认，最大和最小的月
        let defaultMonthStr = MCDateManager_getTimeStrFromDate(defaultDate, dateFormat: "MM")
        let maxMonthStr = MCDateManager_getTimeStrFromDate(maximumDate, dateFormat: "MM")
        let minMonthStr = MCDateManager_getTimeStrFromDate(minimumDate, dateFormat: "MM")
        defaultMonth = Int(defaultMonthStr) ?? 0
        minMonth = Int(minMonthStr) ?? 0
        maxMonth = Int(maxMonthStr) ?? 0
        

        
        // 获取默认，最大和最小的天
        let defaultDayStr = MCDateManager_getTimeStrFromDate(defaultDate, dateFormat: "dd")
        let maxDayStr = MCDateManager_getTimeStrFromDate(maximumDate, dateFormat: "dd")
        let minDayStr = MCDateManager_getTimeStrFromDate(minimumDate, dateFormat: "dd")
        defaultDay = Int(defaultDayStr) ?? 0
        minDay = Int(minDayStr) ?? 0
        maxDay = Int(maxDayStr) ?? 0
        
        
        
        createYearsData()
        createMonthsData()
        createDaysData()

        pickerView.reloadAllComponents()
    }
    
    
    private var dateMode : MCDateMode = MCDateMode.year_month_day
    
    
    /* 记录年月日的数据 */
    
    // 仅用来记录第一次设置的defaultDate
    private var rowYear = 0
    private var rowMonth = 0
    private var rowDay = 0

    private var defaultYear = 0
    private var maxYear  = 0
    private var minYear  = 0

    private var defaultMonth = 0
    private var maxMonth  = 0
    private var minMonth  = 0
    
    private var defaultDay = 0
    private var maxDay  = 0
    private var minDay  = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(pickerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        
        pickerView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)

        
        switch dateMode {
        case .year:
            pickerView.selectRow(rowYear, inComponent: 0, animated: true)
        case .year_month:
            pickerView.selectRow(rowYear, inComponent: 0, animated: true)
            pickerView.selectRow(rowMonth, inComponent: 1, animated: true)
        default:
            pickerView.selectRow(rowYear, inComponent: 0, animated: true)
            pickerView.selectRow(rowMonth, inComponent: 1, animated: true)
            pickerView.selectRow(rowDay, inComponent: 2, animated: true)

        }
        
        callBack()
    }
    
    // 获取
    
    // 定义年的数据，默认初始年
    private func createYearsData() {
        
        yearsArray.removeAllObjects()
        
        let difference = maxYear - minYear
        
        // 最小年份 >= 最大年份
        if difference <= 0 {
            self.yearsArray.add(maxYear)
        } else {
            for i in 0...difference {
                self.yearsArray.add(minYear + i)
            }
        }
        rowYear = self.yearsArray.index(of: defaultYear)
    }
    // 定义月的数据
    private func createMonthsData() {

        monthsArray.removeAllObjects()

        /**
         * 月份的范围情况分析
         * 1. 最小年份 ==  最大年份  ->  minMonth...maxMonth
         * 2. 默认年份 <= 最小年份  ->  minMonth...12
         * 3. 最小年份 < 默认年份 < 最大年份  -> 1...12
         * 4. 默认年份 >= 最大年份  ->  1...maxMonth
         */
        dealMonthsArray(defaultYear: defaultYear, maxYear: maxYear, minYear: minYear, defaultMonth: defaultMonth, maxMonth: maxMonth, minMonth: minMonth)
    
        rowMonth = self.monthsArray.index(of: defaultMonth)
    }
    
    private func dealMonthsArray(defaultYear:Int,maxYear:Int,minYear:Int,defaultMonth:Int,maxMonth:Int,minMonth:Int) {
        // 1. 最小年份 ==  最大年份  ->  minMonth...maxMonth
        if minYear == maxYear {
            for i in minMonth...maxMonth {
                self.monthsArray.add(i)
            }
            return
        }

        
        // 2. 默认年份 <= 最小年份  ->  minMonth...12
        if defaultYear <= minYear {
            for i in minMonth...12 {
                self.monthsArray.add(i)
            }
            return
        }
        
        // 3. 最小年份 < 默认年份 < 最大年份  -> 1...12
        if defaultYear > minYear && defaultYear < maxYear  {
            for i in 1...12 {
                self.monthsArray.add(i)
            }
            return
        }
        
        // 4. 默认年份 >= 最大年份  ->  1...maxMonth
        if defaultYear >= maxYear  {
            for i in 1...maxMonth {
                self.monthsArray.add(i)
            }
            return
        }
    }
    
    
    // 根据年和月定义日的数据 （28、29天，30天，31天）
    private func createDaysData() {
        
        daysArray.removeAllObjects()
        
        dealDaysArray()
        
        rowDay = self.daysArray.index(of: defaultDay)
    }
    
    func dealDaysArray() {
        
        // 获取默认的年和月，获取天数。
        let days = getDaysInMonth(year: defaultYear, month: defaultMonth)
        
        /**
         * 天数的范围情况分析
         * 1. 最小年月 == 最大年月  ->  minDay...maxDay
         * 2. 默认年月 == 最小年月  ->  minDay...days
         * 3. 默认年月 == 默认年月  ->  1...maxDay
         * 4. 其他                ->  1...days
         */
                
        // 1. 最小年月 == 最大年月  ->  minDay...maxDay
        if minYear == maxYear && minMonth == maxMonth {
            for i in minDay...maxDay {
                self.daysArray.add(i)
            }
            return
        }
        
        
        // 2. 默认年月 == 最小年月  ->  minDay...days
        if defaultYear == minYear && defaultMonth == minMonth {
            for i in minDay...days {
                self.daysArray.add(i)
            }
            return
        }
        
        // 3. 默认年月 == 最大年月  ->  1...maxDay
        if defaultYear == maxYear && defaultMonth == maxMonth {
            for i in 1...maxDay {
                self.daysArray.add(i)
            }
            return
        }
        
        // 4. 其他
        for i in 1...days {
            self.daysArray.add(i)
        }
    }

    
    
    // 错误最小，最大，默认时间判断
    private func judgeMin_max_defaultDateIsReasonableTime() {
        /**
         * 判断开始时间，默认时间和结束时间的关系。
         * 开始时间 > 结束时间  返回错误
         * 开始时间 > 默认时间  返回错误
         * 默认时间 > 结束时间  返回错误
         */
        
        if MCDateManager_compareTwoDate(one: minimumDate, two: maximumDate) == 1 {
            print("MCDatePicker->error: 开始时间不允许大于结束时间，系统会将最小时间赋值给最大时间")
            maximumDate = minimumDate
        }
        if MCDateManager_compareTwoDate(one: minimumDate, two: defaultDate) == 1 {
            print("MCDatePicker->error: 开始时间不允许大于默认时间，系统会将最小时间赋值给默认时间")
            defaultDate = minimumDate
        }
        if MCDateManager_compareTwoDate(one: defaultDate, two: maximumDate) == 1 {
            print("MCDatePicker->error: 默认时间不允许大于最大时间，系统会将最大时间赋值给默认时间")
            defaultDate = maximumDate
        }
    }
    
    
    //计算指定月天数
    private func getDaysInMonth( year: Int, month: Int) -> Int {
        let calendar = Calendar.current
        
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        let startDate = calendar.date(from: startComps)
        let endDate = calendar.date(from: endComps)
        let diff = calendar.dateComponents([.day], from: startDate!, to: endDate!)
        
        return diff.day!
    }
    
    
    // 将选中的时间通过闭包返回出去
    public func callBack() {
        var timeStr = ""
        
        let y_index = pickerView.selectedRow(inComponent: 0)
        var m_index = 0
        var d_index = 0
        
        var year = 0
        var month = 0
        var day = 0

        
        
        // 闭包返回时间  根据dateMode返回格式 yyyy  yyyy-MM  yyyy-MM-dd
        switch dateMode {
        case .year:
            
            if yearsArray.count > y_index {
                year = yearsArray[y_index] as! Int
            }
            timeStr += String(year)
        case .year_month:
            if yearsArray.count > y_index {
                year = yearsArray[y_index] as! Int
            }
            timeStr += (String(year) + "-")
            
            m_index = pickerView.selectedRow(inComponent: 1)
            if monthsArray.count > m_index {
                month = monthsArray[m_index] as! Int
            }
            timeStr += String(month)
            
        case .year_month_day:
            
            m_index = pickerView.selectedRow(inComponent: 1)
            d_index = pickerView.selectedRow(inComponent: 2)
            
            if yearsArray.count > y_index {
                year = yearsArray[y_index] as! Int
            }
            timeStr += (String(year) + "-")
            
            if monthsArray.count > m_index {
                month = monthsArray[m_index] as! Int
            }
            timeStr += (String(month) + "-")
            
            if daysArray.count > d_index {
                day = daysArray[d_index] as! Int
            }
            timeStr += String(day)
        }
                
        datePickerClosure?(timeStr)
    }
    
    //MARK: 懒加载
    public lazy var pickerView: UIPickerView = {
        let p = UIPickerView()
        p.dataSource = self
        p.delegate = self
        return p
    }()
    
    private lazy var yearsArray: NSMutableArray = {
        let arrayM = NSMutableArray()
        return arrayM
    }()
    
    private lazy var monthsArray: NSMutableArray = {
        let arrayM = NSMutableArray()
        return arrayM
    }()
    
    private lazy var daysArray: NSMutableArray = {
        let arrayM = NSMutableArray()
        return arrayM
    }()
}

extension MCDatePicker : UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
                
        switch dateMode {
        case .year:
            return 1
        case .year_month:
            return 2
        case .year_month_day:
            return 3
        }
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    public func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return yearsArray.count
        case 1:
            return monthsArray.count
        case 2:
            return daysArray.count
        default:
            return 0
        }
    }
    


    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//    }
    
    //设置行高
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
        -> CGFloat {
            return 44
    }
    
    // 修改选项的字体大小和颜色
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        for view in pickerView.subviews {
            if view.frame.size.height < 1 {
                view.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
            }
        }
        

        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: titleFont)
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = titleColor
        }
        
        
        switch component {
        case 0:
            pickerLabel?.text = "\(yearsArray[row])" + "年"
        case 1:
            pickerLabel?.text = "\(monthsArray[row])" + "月"
        case 2:
            pickerLabel?.text = "\(daysArray[row])"   + "日"
        default:
            break
        }

        
        
        return pickerLabel!
    }
    
    
    // 检测响应选项的选择状态
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {

        if component == 0 {
            // 更新了年， 更新月和天的数据
            defaultYear = yearsArray[row] as! Int
            createMonthsData()
            createDaysData()
        } else if component == 1 {
            // 更新了月，更新天的数据
            defaultMonth = monthsArray[row] as! Int
            createDaysData()
        } else if component == 2 {
            rowDay = row
        }
        
        pickerView.reloadAllComponents()

        callBack()
        
    }
}
