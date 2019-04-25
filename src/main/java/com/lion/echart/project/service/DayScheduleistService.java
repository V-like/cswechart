package com.lion.echart.project.service;

import java.util.List;

import com.lion.echart.base.logic.BaseService;

public interface DayScheduleistService extends BaseService {

	/**
	 *   特殊批量
	 * @param sqlID
	 * @param object
	 */
	public void savedaystatementList(List object) throws Exception;
	
}
