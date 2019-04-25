package com.lion.echart.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lion.echart.base.dao.BaseDao;
import com.lion.echart.base.entity.BaseEntity;

@Service
public class DayScheduleistServiceImpl {
	
	@Autowired
	private BaseDao baseDao;
	
	public void savedaystatementList(List<BaseEntity> dlist)  throws Exception {
		try {
			baseDao.insertOupdates("comle.daystatement.daystatement", dlist);
			for(int i = 0;i < dlist.size();i++) {
				baseDao.updateObject("comle.monthschedule.accumulationcumulantUpdate", dlist.get(i));
			}
		}finally {
			baseDao.closeCon();
		}
	}

}