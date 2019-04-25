package com.lion.echart.base.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.lion.echart.base.dao.BaseDao;

public class BaseServiceImpl implements BaseService{

	@Autowired
	protected BaseDao baseDao;
	
	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public void updateObject(String sqlid, Object object) throws Exception{
		
		try {
			baseDao.updateObject(sqlid, object);
		}finally {
			baseDao.closeCon();
		}
		
	}
	
	public void insertObject(String sqlid, Object object) throws Exception{
		try {
			baseDao.insertObject(sqlid, object);
		}finally {
			baseDao.closeCon();
		}
	}
	
	public int delete(String sqlid, Object param) {
		int result = 0; 
		try {
			result = baseDao.delete(sqlid, param);
		}finally {
			baseDao.closeCon();
		}

		return result;
	}

	public List queryList(String sqlid, Object param) {
		return baseDao.queryList(sqlid, param);
	}
	
	public List queryListByPage(String sqlid, Object param) {
		return baseDao.queryListByPage(sqlid, param);
	}

	public Object queryObject(String sqlid, Object param) {
		return baseDao.queryObject(sqlid, param);
	}

	public void insertOupdates(String sqlID, List object) throws Exception {
		try {
			baseDao.insertOupdates(sqlID, object);
		}finally {
			baseDao.closeCon();
		}
	}

	public void updateBatchBySQL(String sqlID, Object object) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void insertBatchBySQL(String sqlID, Object object) throws Exception {
		// TODO Auto-generated method stub
		
	}

}