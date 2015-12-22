package org.learncommunity.test;

import junit.framework.TestCase;
import org.junit.Test;
import org.learncommunity.util.MD5Encode;
import org.springframework.test.context.ContextConfiguration;

/**
 * Created by LJT on 2015/12/9.
 */
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class JoinTest extends TestCase{
/*    @Resource
    private TopicService topicService;

    private static Logger logger = Logger.getLogger(JoinTest.class);

    @Test
    public void test(){
        List<Topic> list = topicService.queryForList();
        for (Topic topic : list){
            logger.info(topic.getInformation() + topic.getReplys().size());
        }
    }*/
    /*<resultMap id="queryForListMap" type="org.learncommunity.entity.Topic">
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="userid" property="userid" jdbcType="INTEGER" />
    <result column="title" property="title" jdbcType="VARCHAR" />
    <result column="time" property="time" jdbcType="TIMESTAMP" />
    <result column="information" property="information" jdbcType="VARCHAR" />
    <result column="lastreplytime" property="lastreplytime" jdbcType="TIMESTAMP" />
    <result column="replycnt" property="replycnt" jdbcType="INTEGER" />
    <result column="type" property="type" jdbcType="VARCHAR" />
    <collection property="replys" javaType="java.util.List" ofType="org.learncommunity.entity.Reply">
    <id column="r_id" property="id" jdbcType="INTEGER" />
    <result column="r_topicid" property="topicid" jdbcType="INTEGER" />
    <result column="r_userid" property="userid" jdbcType="INTEGER" />
    <result column="r_time" property="time" jdbcType="TIMESTAMP" />
    <result column="r_information" property="information" jdbcType="VARCHAR" />
    <result column="r_root" property="root" jdbcType="INTEGER" />
    </collection>
    </resultMap>

    <sql id="Base_Column_List" >
    id, userid, title, time, information, lastreplytime, replycnt, type
            </sql>

    <select id="queryForList" resultMap="queryForListMap">
    SELECT
    t.id,
    t.userid,
    t.title,
    t.time,
    t.information,
    t.lastreplytime,
    t.replycnt,
    t.type,
    r.id r_id,
    r.topicid r_topicid,
    r.userid r_userid,
    r.time r_time,
    r.information r_information,
    r.root r_root
    FROM
    topic t
    LEFT JOIN
    reply r
    ON
    t.id = r.topicid
            </select>

                SELECT
    m.id, m.name, m.uploaderid, m.type, m.time, m.root, m.description, m.url, m.price,
    u.id u_id, u.email u_email, u.name u_name, u.password u_password, u.phone u_phone, u.brithday u_brithday,
    u.address u_adderss, u.description u_description, u.educationalbackground u_educationalbackground,
    u.goodat u_goodat, u.photourl u_photourl, u.classcnt u_classcnt, u.topiccnt u_topiccnt, u.replycnt u_replycnt,
    u.root u_root
    FROM
    media m
    LEFT JOIN
    user u
    ON
    m.uploaderid = u.id

            */

    @Test
    public void test(){
        System.out.println(MD5Encode.MD5("asd"));
    }

}
