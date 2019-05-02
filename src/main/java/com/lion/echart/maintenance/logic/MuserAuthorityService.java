package com.lion.echart.maintenance.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lion.echart.base.dao.BaseDao;

@Service("muserAuthorityService")
public class MuserAuthorityService {

	@Autowired
	protected BaseDao baseDao;

	public void saveMuserList(List malist,Long leftid)  throws Exception {
		try {
			baseDao.delete("comle.muserauthority.deleteMuseraByLeftif", leftid);
			
			for(int i = 0;i < malist.size();i++) {
				baseDao.insertObject("comle.muserauthority.muserauthoritySave", malist.get(i));
			}
		}finally {
			baseDao.closeCon();
		}
	}
}