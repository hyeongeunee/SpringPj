package com.test.spring.cafe.dao;

import com.test.spring.cafe.dto.CafeDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CafeDaoImpl implements CafeDao {

    @Autowired
    private SqlSession session;

    @Override
    public List<CafeDto> getList(CafeDto dto) {

        return session.selectList("cafe.getList", dto);
    }

    @Override
    public int getCount(CafeDto dto) {

        return session.selectOne("cafe.getCount", dto);
    }

    @Override
    public void insert(CafeDto dto) {
        session.insert("cafe.insert", dto);
    }

    @Override
    public CafeDto getData(int num) {

        return session.selectOne("cafe.getData", num);
    }

    @Override
    public CafeDto getData(CafeDto dto) {

        return session.selectOne("cafe.getData2", dto);
    }

    @Override
    public void addViewCount(int num) {
        session.update("cafe.addViewCount", num);
    }

    @Override
    public void delete(int num) {
        session.delete("cafe.delete", num);
    }

    @Override
    public void update(CafeDto dto) {
        session.update("cafe.update", dto);
    }

}