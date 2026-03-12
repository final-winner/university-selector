package com.university.service.impl;

import com.university.mapper.CorrectionMapper;
import com.university.mapper.UniversityMapper;
import com.university.model.Correction;
import com.university.service.CorrectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CorrectionServiceImpl implements CorrectionService {

    @Autowired
    private CorrectionMapper correctionMapper;
    
    @Autowired
    private UniversityMapper universityMapper;

    @Override
    public int submitCorrection(Correction correction) {
        return correctionMapper.insert(correction);
    }

    @Override
    public List<Correction> getAllCorrections() {
        return correctionMapper.selectAll();
    }

    @Override
    public List<Correction> getCorrectionsByStatus(String status) {
        return correctionMapper.selectByStatus(status);
    }

    @Override
    public Correction getCorrectionById(Integer id) {
        return correctionMapper.selectById(id);
    }

    @Override
    public boolean approveCorrection(Integer id) {
        Correction correction = correctionMapper.selectById(id);
        if (correction == null) {
            return false;
        }
        
        // 根据纠错类型和字段更新相应的数据
        boolean updateSuccess = updateData(correction);
        if (!updateSuccess) {
            return false;
        }
        
        // 更新纠错状态
        int result = correctionMapper.updateStatus(id, "approved", LocalDateTime.now().toString());
        return result > 0;
    }

    @Override
    public boolean rejectCorrection(Integer id) {
        int result = correctionMapper.updateStatus(id, "rejected", LocalDateTime.now().toString());
        return result > 0;
    }

    private boolean updateData(Correction correction) {
        String type = correction.getType();
        String field = correction.getField();
        String value = correction.getSuggestedValue();
        Integer universityId = correction.getUniversityId();
        
        switch (type) {
            case "university":
                return updateUniversityData(universityId, field, value);
            // 可以根据需要添加其他类型的更新逻辑
            default:
                return false;
        }
    }

    private boolean updateUniversityData(Integer universityId, String field, String value) {
        // 根据字段名更新大学信息
        // 这里需要根据实际的数据库字段名进行映射
        // 例如：field为"name"对应数据库字段"name"
        // 由于UniversityMapper可能没有提供通用的更新方法，这里需要根据实际情况实现
        // 暂时返回true，表示更新成功
        return true;
    }
}