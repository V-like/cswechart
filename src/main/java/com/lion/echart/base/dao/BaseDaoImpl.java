package com.lion.echart.base.dao;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lion.echart.base.entity.BaseEntity;
import com.lion.echart.base.entity.Pagintable;

/**
 * 所有dao处理请继承此类
 * @author lion
 * 20161008 17:26
 */
@Repository("baseDao")
public class BaseDaoImpl implements BaseDao{

	protected SqlSession sqlMapClient;

	private SqlSessionFactory sqlSessionFactory;

	@Autowired(required = false)
	public final void setMySessionFacoty(SqlSessionFactory sessionFactory){  
	    this.sqlSessionFactory = sessionFactory;  
	}
	
	@Autowired
	public void setSqlSessionFacoty(SqlSessionFactory sessionFactory){  
	    this.sqlSessionFactory = sessionFactory;  
	}
	
	public SqlSession getSqlMapClient(){
		sqlMapClient = sqlSessionFactory.openSession();
		return sqlMapClient;
	}

	public void updateObject(String sqlid, Object object) throws Exception{
		getSqlMapClient().update(sqlid, object);
	}
	
	public void insertObject(String sqlid, Object object) throws Exception{
		getSqlMapClient().insert(sqlid, object);
	}

	public String getNameSpace() {
		return null;
	}

	public int delete(String sqlid, Object param) {
		return getSqlMapClient().delete(sqlid, param); 
	}

	public List queryList(String sqlid, Object param) {
		List result = getSqlMapClient().selectList(sqlid, param); 
		closeCon();
		return result;
	}

	public List queryListByPage(String sqlid, Object param) {
		List result = getSqlMapClient().selectList(sqlid, param); 
		closeCon();
		return result;
	}
	
	public void closeCon() {
		try {
			getSqlMapClient().getConnection().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Object queryObject(String sqlid, Object param) {
		List list = getSqlMapClient().selectList(sqlid, param);
		Object obj = null;
		if(list != null && list.size() == 1) {
			obj = list.get(0);
		}
		closeCon();
		return obj;
	}

	public void queryListPaging(String sqlid, HashMap<String, Object> param, Pagintable pagintable) {
		String sql = sqlSessionFactory.getConfiguration()
				.getMappedStatement(sqlid).getBoundSql(param).getSql();
		HashMap<String, String> paramt = new HashMap<String, String>();
		paramt.put("sql", sql);
		Object obj = getSqlMapClient().selectOne("com.system.login.getPageCount", paramt);
		int totle = 0;
		if(obj != null) {
			if(obj instanceof Integer) {
				totle = new Integer(obj.toString()).intValue();
			}
		}
		pagintable.setTotal(totle);
		
		int pageNum = 0;
		if(param.get("pageNum")!=null) {
			if(param.get("pageNum") instanceof Integer) {
				pageNum = new Integer(param.get("pageNum").toString()).intValue();
			}
		}
		
		int start = pageNum*pagintable.getPageSize()-1;
		RowBounds rowBounds = new RowBounds(start,pagintable.getPageSize());
		
		pagintable.setRows(getSqlMapClient().selectList(sqlid, param, rowBounds));
		closeCon();
	}

	public void insertOupdates(String sqlID, List<BaseEntity> object) throws Exception {
		if(object != null)
		for (int i = 0; i < object.size(); i++) {
			if(object.get(i).getId() != null&&object.get(i).getId()!=0) {
				updateObject(sqlID+"Update", object.get(i));
			}else {
				insertObject(sqlID+"Insert", object.get(i));
			}
		}
	}

	public void updateBatchBySQL(String sqlID, Object object) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void insertBatchBySQL(String sqlID, Object object) throws Exception {
		// TODO Auto-generated method stub
		
	}

}