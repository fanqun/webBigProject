package com.cyan.service.Impl;

import com.cyan.dao.IClzDao;
import com.cyan.entity.Course;
import com.cyan.service.IClzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 功能描述:
 *
 * @Author cyan
 * @Date 16/7/6.
 */

@Service
public class ClzService implements IClzService {

    @Autowired
    private IClzDao clzDao;

    @Override
    public List<Course> getAllClz() {
        return clzDao.selectAll();
    }
}