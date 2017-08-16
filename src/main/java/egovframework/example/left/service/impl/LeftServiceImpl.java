package egovframework.example.left.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.left.service.LeftService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("leftService")
public class LeftServiceImpl extends EgovAbstractServiceImpl implements LeftService {
	
	@Resource(name = "leftMapper")
	private LeftMapper leftMapper;
	@Override
	public List<?> selectLeftList() throws Exception {
		return leftMapper.selectLeftList();
	}

}
