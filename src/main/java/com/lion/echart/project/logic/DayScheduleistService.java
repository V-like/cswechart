package com.lion.echart.project.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lion.echart.base.dao.BaseDao;

@Service("dayScheduleistService")
public class DayScheduleistService{

	@Autowired
	protected BaseDao baseDao;
	
	public void savedaystatementList(List dlist)  throws Exception {
		try {
			baseDao.insertOupdates("comle.daystatement.daystatement", dlist);
			for(int i = 0;i < dlist.size();i++) {
				System.out.println("=================================="+dlist.get(i));
				baseDao.updateObject("comle.monthschedule.accumulationcumulantUpdate", dlist.get(i));
			}
			for(int i = 0;i < dlist.size();i++) {
				
				baseDao.updateObject("comle.Maintenance.accumulationcumulantUpdate", dlist.get(i));
			}
		}finally {
			baseDao.closeCon();
		}
	}

}
