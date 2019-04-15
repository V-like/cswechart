package com.lion.echart.base.logic;

import java.util.List;

import com.lion.echart.base.entity.BaseEntity;

/**
 * 定义service层中常用方法的接口
 * @author lion风
 *
 */
public interface BaseService {
	
	/**
	 * 批量新增修改
	 * @param sqlID
	 * @param object
	 */
	public void insertOupdates(String sqlID, List object) throws Exception;
	
	/**
	 * 新增
	 * @param sqlID
	 * @param object
	 * @throws Exception
	 */
	public void insertObject(String sqlID, Object object) throws Exception;
	
	/**
	 * 修改
	 * @param sqlID
	 * @param object
	 * @throws Exception
	 */
	public void updateObject(String sqlID, Object object) throws Exception;
	
	/**
	 * 传sqlid的删除方法
	 * @param sqlid
	 * @param obj
	 * @return
	 */
	public abstract int delete(String sqlid,Object param);

	/**
	 * 统一查询列表方法
	 * @param sqlid
	 * @param param
	 * @return
	 */
	public abstract List queryList(String sqlid, Object param);

	/**
	 * 统一查询分页列表方法
	 * @param sqlid
	 * @param param
	 * @return
	 */
	public abstract List queryListByPage(String sqlid, Object param);
	
	/**
	 * 统一查询对象方法
	 * @param sqlid
	 * @param param
	 * @return
	 */
	public abstract Object queryObject(String sqlid, Object param);

	/**
	 * 统一分页查询方法
	 * @param sqlid
	 * @param param
	 * @param pagingParameter
	 * @return
	 */
	//public abstract PagingResult queryListPaging(String sqlid, Object param, PagingParameter pagingParameter);

	/**
	 * 批量更新
	 * @param sqlID
	 * @param object
	 * @throws Exception
	 */
	public void updateBatchBySQL(String sqlID, Object object) throws Exception;
	
	/**
	 * 批量新增
	 * @param sqlID
	 * @param object
	 * @throws Exception
	 */
	public void insertBatchBySQL(String sqlID, Object object) throws Exception ;
	
}